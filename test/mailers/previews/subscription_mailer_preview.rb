# Preview all emails at http://localhost:3000/rails/mailers/subscription_mailer
class SubscriptionMailerPreview < ActionMailer::Preview
    def student_subscription
        SubscriptionMailer.student_subscription(Subscription.first).deliver_now
    end

    def teacher_subscription
        SubscriptionMailer.teacher_subscription(Subscription.first).deliver_now
    end
end
