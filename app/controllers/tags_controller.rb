class TagsController < ApplicationController
  def index
    @tags = Tag.all.order(course_tags_count: :desc)
    authorize @tags
  end
  
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render json: @tag
    else
      render json: {errors: @tag.errors.full_messages}
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
      authorize @tag
     if @tag.destroy
       redirect_to @tag, notice: "Tag was successfully destroyed."
    # else
    #    redirect_to course_url, alert: "Course can't be deleted because it has a subscription" 
     end
  end
  

  def tag_params
    params.require(:tag).permit(:name)
  end
end
