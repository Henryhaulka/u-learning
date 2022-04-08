class HomeController < ApplicationController
  skip_before_action :authenticate_user!, except: %i[ index, privacy_policy]
  def index
     @latest_courses = Course.publish.approve.recent.limiter
     @my_subscriptions = Course.joins(:subscriptions).where(subscriptions: {user_id: current_user})
     @popular_courses = Course.publish.approve.popular.recent.limiter
     @top_rated_courses = Course.publish.approve.top.recent.limiter
     @reviews = Subscription.reviewed.rater.recent.limiter.order(rating: :desc)
  end

  def activity
    if current_user.has_role?(:admin)
      #  @activities = PublicActivity::Activity.all.order(created_at: :desc)
      @pagy,@activities = pagy(PublicActivity::Activity.all.order(created_at: :desc))
    else
       redirect_to root_path, alert: 'Access Denied!! You are not Authorized'
    end
  end

  def analytics
    if current_user.has_role?(:admin)
      #  @user = User.all
      #  @subscriptions = Subscription.all
      #  @courses = Course.all
    else
       redirect_to root_path, alert: 'Access Denied!! You are not Authorized'
    end
  end
  

  def privacy_policy
  end
  
  
end
