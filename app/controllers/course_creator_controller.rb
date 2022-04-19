class CourseCreatorController < ApplicationController
    include Wicked::Wizard

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
end
