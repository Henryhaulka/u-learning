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
    if current_user.has_role?(:admin)
       @activities = PublicActivity::Activity.all
    else
       redirect_to root_path, alert: 'Access Denied!! You are not Authorized'
    end
  end

  def analytics
    if current_user.has_role?(:admin)
       @user = User.all
       @subscriptions = Subscription.all
       @courses = Course.all
    else
       redirect_to root_path, alert: 'Access Denied!! You are not Authorized'
    end
  end
  
  
end
