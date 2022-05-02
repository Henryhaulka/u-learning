class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_searching_varaible, if: :user_signed_in?
  include PublicActivity::StoreController 
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  after_action :user_activity
   include Pagy::Backend

  private

  def user_activity
    current_user.try :touch
  end
  

  def user_not_authorized #pundit
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def set_searching_varaible
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search)  
  end
end
