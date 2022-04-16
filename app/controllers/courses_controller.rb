class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy approve unapprove analytics]
  skip_before_action :authenticate_user!, only: :show
  # GET /courses or /courses.json
  def index
    # if params[:title]
    #   @courses = Course.where('title ILIKE ?', "%#{params[:title]}%") #case in-sensitive
    # else
      # @q = Course.ransack(params[:q])
      # @courses = @q.result.includes(:user)
      #  @ransack_courses = Course.ransack(params[:courses_search], key: :courses_search)
      # if current_user.has_role?(:admin)
        #  @courses = @ransack_courses.result.includes(:user)
          @tags = Tag.all.where.not(course_tags_count: 0).order(course_tags_count: :desc).limit(10)
          @ransack_path = courses_path
          @ransack_courses = Course.recent.publish.approve.ransack(params[:courses_search], search_key: :courses_search)  
          # :course_tags, :course_tags => :tag using the through table to get a tag
          @pagy,@courses = pagy(@ransack_courses.result.includes(:user, :course_tags, :course_tags => :tag))
          
      # else
      #   redirect_to root_path, alert: 'You are not authorized'
      # end
     
    # end
  end

  # GET /courses/1 or /courses/1.json
  def show
    authorize @course
    @course_lessons = @course.lessons.recent_lessons.rank(:row_order)
    @subscriptions_reviews = @course.subscriptions.reviewed
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name",   # Excluding ".pdf" extension.
        page_size: 'A4',
        template: 'courses/show.pdf.haml',
        layout: 'pdf.html.haml',
        orientation: 'Portrait',
        lowquality: true,
        dpi: 75,
        zoom: 1
      end
    end
  end

  def purchased_courses
      @ransack_path = purchased_courses_courses_path
      @tags = Tag.all.where.not(course_tags_count: 0).order(course_tags_count: :desc)
    # @courses =  Course.joins(:subscriptions).where(subscriptions: {user_id: current_user})
    #joins is used to join tables
    ##a course has many subscriptions hence .joins(:subscriptions) subscriptions is plural
    @ransack_courses = Course.joins(:subscriptions).where(subscriptions: {user_id: current_user}).ransack(params[:courses_search])
     @pagy,@courses = pagy(@ransack_courses.result.includes(:user, :course_tags, :course_tags => :tag))
    render 'index'
  end

  def analytics
     authorize @course, :owner?
  end
  

  def pending_reviews
    @ransack_path = pending_reviews_courses_path
     @tags = Tag.all.where.not(course_tags_count: 0).order(course_tags_count: :desc)
    #MERGE is used to add a scope here
    @ransack_courses = 
      Course.joins(:subscriptions).where(subscriptions: 
      {rating: [0,nil, ""], review: [0,nil, "", ], user_id: current_user}).ransack(params[:courses_search])
     @pagy,@courses = pagy(@ransack_courses.result.includes(:user, :course_tags, :course_tags => :tag))
    render 'index'
  end

  def created_courses
    @ransack_path = created_courses_courses_path
    @tags = Tag.all.where.not(course_tags_count: 0).order(course_tags_count: :desc)
    @ransack_courses = Course.recent.where(user_id: current_user).ransack(params[:courses_search])
     @pagy,@courses = pagy(@ransack_courses.result.includes(:user, :course_tags, :course_tags => :tag))
    render 'index' 
  end

  def unapproved_courses
    @ransack_path = unapproved_courses_courses_path
     @tags = Tag.all.where.not(course_tags_count: 0).order(course_tags_count: :desc)
    @ransack_courses = Course.unapprove.order(created_at: :desc).ransack(params[:courses_search])
     @pagy,@courses = pagy(@ransack_courses.result.includes(:user, :course_tags, :course_tags => :tag))
    render 'index' 
  end

  def approve
    authorize @course, :approve_policy?
    @course.update_attribute(:approved, true)
    redirect_to course_path(@course), notice: 'Course successfully approved and visible'
  end

  def unapprove
     authorize @course, :approve_policy?
    @course.update_attribute(:approved, false)
    redirect_to course_path(@course), alert: 'Course successfully unapproved and hidden'
  end
  
  # GET /courses/new
  def new
    @course = Course.new
    authorize @course
    @tags = Tag.all
  end

  # GET /courses/1/edit
  def edit
    authorize @course
    @tags = Tag.all
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)
    @course.user = current_user
 
     authorize @course

    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        @tags = Tag.all
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    authorize @course
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
         @tags = Tag.all
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    authorize @course
    if @course.destroy
      respond_to do |format|
        format.html { redirect_to courses_url, alert: "Course was successfully destroyed." }
        format.json { head :no_content }
      end
    else
       redirect_to course_url, alert: "Course can't be deleted because it has a subscription" 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:title, :description, :short_description, :level, :published, :price, :language, :avatar, tag_ids: [])
    end
end
