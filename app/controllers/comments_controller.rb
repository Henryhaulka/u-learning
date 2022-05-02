class CommentsController < ApplicationController
  before_action :set_required
    # def new
        
    # end
        
    def create
       @comment = Comment.new(set_comment)
       @comment.lesson =  @lesson
       @comment.user = current_user
      if @comment.save
         redirect_to course_lesson_url(@course,@lesson), notice: "Comment was successfully created." 
      else
          render 'lessons/comments/new'
      end
    end

    def destroy
      @comment = Comment.find(params[:id])
      authorize @comment
      @comment.destroy
      redirect_to course_lesson_path(@course, @lesson), alert: "Course was successfully destroyed." 
    end

    def edit
      @comment = Comment.find(params[:id])
      authorize @comment
    end

    def update
      
      @comment = Comment.find(params[:id])
      if @comment.update(set_comment)
        redirect_to course_lesson_path(@course, @lesson), notice: "Course was successfully Updated."
      else
          redirect_to course_lesson_path(@course, @lesson), alert: "Not AUTHORIZED."
      end
    end
    
    
    

    private 
    def set_comment
        params.require(:comment).permit(:content)
    end

    def set_required
      @course = Course.friendly.find(params[:course_id])
      @lesson = Lesson.friendly.find(params[:lesson_id])
    end
    
    
end
