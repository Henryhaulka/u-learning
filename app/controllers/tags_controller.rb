class TagsController < ApplicationController
  def index
    @tags = Tag.all.order(course_tags_count: :desc)
  end
  
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render json: @tag
    else
      render json: {errors: @tag.errors.full_messages}
    end
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
