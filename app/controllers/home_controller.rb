class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
     @courses = Course.all.limit(3)
     @latest_courses = Course.all.limiter.recent
  end

  def activity
    @activities = PublicActivity::Activity.all
  end
  
end
