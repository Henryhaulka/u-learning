class Courses::CourseWizardController < ApplicationController
    include Wicked::Wizard
    # before action should not be b4 the include module
  before_action :set_progress, only: :show
  steps :basic_info, :details

    def show
        # @user = current_user
        # case step
        # when :find_friends
        #     @friends = @user.find_friends
        # end
        render_wizard
    end

    def finish_wizard_path
        @course = Course.friendly.find(params[:course_id])
        course_path(@course)
    end
     
    private
    def set_progress
        if wizard_steps.any? && wizard_steps.index(step).present?#if a current step exist
          @progress = ((wizard_steps.index(step) + 1).to_f / (wizard_steps.count).to_f * 100 )   
        else
            @progress = 0
        end
    end
    
end
