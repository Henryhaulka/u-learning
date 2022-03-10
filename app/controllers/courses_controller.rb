class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]

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
          @ransack_path = courses_path
          @pagy,@courses = pagy(@ransack_courses.result.includes(:user))
      # else
      #   redirect_to root_path, alert: 'You are not authorized'
      # end
     
    # end
  end

  # GET /courses/1 or /courses/1.json
  def show
    @course_lessons = @course.lessons.recent_lessons
  end

  def purchased_courses
      @ransack_path = purchased_courses_courses_path
    # @courses =  Course.joins(:subscriptions).where(subscriptions: {user_id: current_user})
    #joins is used to join tables
    ##a course has many subscriptions hence .joins(:subscriptions) subscriptions is plural
    @pagy,@courses = pagy(Course.joins(:subscriptions).where(subscriptions: {user_id: current_user}))
    render 'index'
  end

  def pending_reviews
    @ransack_path = pending_reviews_courses_path
    #MERGE is used to add a scope here
    @pagy,@courses = 
      pagy(Course.joins(:subscriptions).where(subscriptions: 
      {rating: [0,nil, ""], review: [0,nil, "", ], user_id: current_user}))
    render 'index'
  end

  def created_courses
    @ransack_path = created_courses_courses_path
    @pagy,@courses = pagy(Course.where(user_id: current_user))
    render 'index'
    
  end
  
  
  

  # GET /courses/new
  def new
    @course = Course.new
    authorize @course
  end

  # GET /courses/1/edit
  def edit
    authorize @course
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
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    authorize @course
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:title, :description, :short_description, :level, :price, :language)
    end
end
