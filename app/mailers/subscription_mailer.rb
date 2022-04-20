class SubscriptionMailer < ApplicationMailer
    def new_subscription(subscription)
        @subscription = subscription
        @course = @subscription.course
        mail(to: @subscription.user.email, subject: "You have successfully subscribed to: #{@course.title}")
        mail(to: @subscription.course.user.email, subject: "You have a new subscriber to: #{@course.title}")
    end
end
