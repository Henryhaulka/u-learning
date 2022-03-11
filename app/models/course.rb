class Course < ApplicationRecord
    validates :title,:short_description,:price,:level,:language, presence: true
    validates :description,presence: true, length: {minimum: 5}
    has_rich_text :description
    belongs_to :user, counter_cache: true
    # User.find_each {|user|User.reset_counters(user.id, :courses )}
    has_many :lessons, dependent: :destroy
    has_many :subscriptions, dependent: :destroy
    
    extend FriendlyId
    friendly_id :title, use: :slugged
    scope :recent, -> {order(created_at: :desc)}
    scope :limiter, -> {limit(3)}
    
    LANGUAGES = [ :English, :French, :Spanish, :Russian]
    def self.languages
        LANGUAGES.each {|language| language}
    end

    LEVELS = [ :Beginner, :Intermediate, :Advanced]
    def self.levels
        LEVELS.each {|level| level}
    end
    
    include PublicActivity::Model
    tracked owner: Proc.new{ |controller, model| controller.current_user }

    def user_subscribed?(user)
        self.subscriptions.where(course_id: self.id, user_id: user.id).present?
    end

    def update_rating
        if subscriptions.present? && subscriptions.where.not(rating: nil)
            update_column :average_rating, (subscriptions.average(:rating).round(2).to_f)
        else
            update_column :average_rating, (0.0)
        end
    end
    
end
