class ChartsController < ApplicationController
  def user_per_day
    #USERs.count against user.day_created
    render json: User.group_by_day(:created_at).count
  end

  def subscriptions_per_day
    render json: Subscription.group_by_day(:created_at).count
  end

  def course_popularity
    #course.title against Subscription.count(x)
    render json: Subscription.joins(:course).group("title").count
  end

  def money_makers
    #course.title against Subscription.sum(x)
    render json: Subscription.joins(:course).group("title").sum(:price)
  end
end