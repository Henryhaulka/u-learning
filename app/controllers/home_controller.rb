class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
     @latest_courses = Course.recent.limiter
     @my_subscriptions = Course.joins(:subscriptions).where(subscriptions: {user_id: current_user})
     @popular_courses = Course.popular.recent.limiter
     @top_rated_courses = Course.top.recent.limiter
     @reviews = Subscription.reviewed.rater.recent.limiter.order(rating: :desc)
  end

  def activity
    @activities = PublicActivity::Activity.all
  end
  
end
