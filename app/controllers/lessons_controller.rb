class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[ show edit update destroy delete_video ]
  
  def sort
    @course = Course.friendly.find(params[:course_id])
    lesson = Lesson.friendly.find(params[:lesson_id])#only cos sort method is not dependent on this controller
    # Lesson.friendly.find(params[:id]) on a norms
    authorize lesson, :edit?
    lesson.update(lesson_params)
    render body: nil
  end

  def delete_video
    authorize @lesson, :edit?
    # method .purge comes from active storage doc
    @lesson.video.purge
    @lesson.video_thumbnail.purge
    redirect_to edit_course_lesson_path(@course, @lesson), alert: 'Video successfully deleted'
  end
  
  
  # GET /lessons or /lessons.json
  def index
    @lessons = Lesson.all
  end

  # GET /lessons/1 or /lessons/1.json
  def show
    authorize @lesson
    current_user.view(@lesson)
    @course_lessons = @course.lessons.recent_lessons.rank(:row_order)
    @comment = Comment.new
    @comments = @lesson.comments.order(created_at: :desc)
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
    @course = Course.friendly.find(params[:course_id])
    # authorize @lesson
  end

  # GET /lessons/1/edit
  def edit
    authorize @lesson
  end

  # POST /lessons or /lessons.json
  def create
    @lesson = Lesson.new(lesson_params)
    @course = Course.friendly.find(params[:course_id])
    @lesson.course = @course 
    authorize @lesson
    respond_to do |format|
      if @lesson.save
        format.html { redirect_to course_lesson_url(@course,@lesson), notice: "Lesson was successfully created." }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1 or /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to course_lesson_url(@course, @lesson), notice: "Lesson was successfully updated." }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1 or /lessons/1.json
  def destroy
    authorize @lesson
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to course_url(@course), alert: "Lesson was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
       @course = Course.friendly.find(params[:course_id])
       @lesson = Lesson.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      #we didn't include "course_id" here since it was in the actions above
      #if included here, it might easy to hack
      params.require(:lesson).permit(:title, :content, :row_order_position, :video, :video_thumbnail)
    end
end
