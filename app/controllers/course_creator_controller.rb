class CourseCreatorController < ApplicationController
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
        courses_path
    end
     
    private
    def set_progress
        if wizard_steps.any?
          @progress = ((wizard_steps.index(step) + 1).to_f / (wizard_steps.count).to_f * 100 )   
        else
            @progress = 0
        end
    end
    
end
