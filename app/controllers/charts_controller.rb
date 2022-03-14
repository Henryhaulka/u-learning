class ChartsController < ApplicationController
  def user_per_day
    render json: User.group_by_day(:created_at).count
  end

  def subscriptions_per_day
    render json: Subscription.group_by_day(:created_at).count
  end

  def course_popularity
    render json: Subscription.joins(:course).group("title").count
  end
end