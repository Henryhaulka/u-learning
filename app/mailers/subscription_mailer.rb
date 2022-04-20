class SubscriptionMailer < ApplicationMailer
    def student_subscription(subscription)
        @subscription = subscription
        @course = @subscription.course
        mail(to: @subscription.user.email, subject: "You have successfully subscribed to: #{@course.title}")
    end

    def teacher_subscription(subscription)
        @subscription = subscription
        @course = @subscription.course
        mail(to: @subscription.course.user.email, subject: "You have a new subscriber to: #{@course.title}")
    end
end
