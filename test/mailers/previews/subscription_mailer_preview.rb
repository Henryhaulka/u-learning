# Preview all emails at http://localhost:3000/rails/mailers/subscription_mailer
class SubscriptionMailerPreview < ActionMailer::Preview
    def new_subscription
        SubscriptionMailer.new_subscription(Subscription.all).deliver_now
    end
    

end
