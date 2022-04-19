class Courses::CourseWizardController < ApplicationController
    include Wicked::Wizard
    # before action should not be b4 the include module
  before_action :set_course, only: [:show, :finish_wizard_path, :update]
  before_action :set_progress, only: [:show, :update]
  steps :basic_info, :details

    def show
       case step
            when :basic_info
            when :details
              @tags = Tag.all
        end
        render_wizard
    end

    def finish_wizard_path
        course_path(@course)
    end

    def update
        case step
            when :basic_info
              @course.update(course_params)
            when :details
              @tag = Tag.all
              @course.update(course_params)
        end
         render_wizard @course #render wizard 4 course
    end
    
     
    private
    def set_progress
        if wizard_steps.any? && wizard_steps.index(step).present?#if a current step exist
          @progress = ((wizard_steps.index(step) + 1).to_f / (wizard_steps.count).to_f * 100 )   
        else
            @progress = 0
        end
    end

    def course_params
      params.require(:course).permit(:title, :description, :short_description, :level, :published, :price, :language, :avatar, tag_ids: [])
    end

    def set_course
      @course = Course.friendly.find(params[:course_id])
    end

    
end
