class CommentsController < ApplicationController
    def new
        
    end
    
    
    def create
       @course = Course.friendly.find(params[:course_id])
       @lesson = Lesson.friendly.find(params[:lesson_id])
       @comment = Comment.new(set_comment)
       @comment.lesson =  @lesson
       @comment.user = current_user
      if @comment.save
         redirect_to course_lesson_url(@course,@lesson), notice: "Comment was successfully created." 
      else
          render 'lessons/comments/new'
      end
    end

    private 
    def set_comment
        params.require(:comment).permit(:content)
    end
    
end
