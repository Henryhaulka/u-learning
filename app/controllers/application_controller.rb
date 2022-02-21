class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :set_searching_varaible, if: :user_signed_in?
    
    def set_searching_varaible
      @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search)  
    end
    
end
