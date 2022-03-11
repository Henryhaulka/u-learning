class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
     @latest_courses = Course.limiter.recent
     @my_subscriptions = Course.joins(:subscriptions).where(subscriptions: {user_id: current_user})
     @popular_courses = Course.order(subscriptions_count: :desc).recent.limiter
     @top_rated_courses = Course.order(average_rating: :desc).recent.limiter
     @reviews = Subscription.reviewed.order(rating: :desc).recent.limiter
  end

  def activity
    @activities = PublicActivity::Activity.all
  end
  
end
