class Course < ApplicationRecord
    validates :title,:short_description,:price,:level,:language, presence: true
    validates :description,presence: true, length: {minimum: 5}
    validates :title, uniqueness: true
    has_rich_text :description
    belongs_to :user, counter_cache: true
    # User.find_each {|user|User.reset_counters(user.id, :courses )}

    has_many :lessons, dependent: :destroy

    #:restrict_with_error - a course can't be deleted if it has a subscription
    has_many :subscriptions, dependent: :restrict_with_error
    
    #a course has lessons, also checked_lessons via lessons
    #use the lesson.id to find it in the user_lessons table
    has_many :checked_lessons, through: :lessons, source: :user_lessons

    extend FriendlyId
    friendly_id :title, use: :slugged
    
    scope :recent, -> {order(created_at: :desc)}
    scope :limiter, -> {limit(3)}
    scope :popular, -> {order(subscriptions_count: :desc)}
    scope :top, -> {order(average_rating: :desc).limiter}
    scope :approve, -> {where(approved: true)}
    scope :unapprove, -> {where(approved: false)}
    scope :publish, -> {where(published: true)}
    scope :unpublish, -> {where(published: false)}
    
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
            update_column :average_rating, (subscriptions.average(:rating).to_f)
        else
            update_column :average_rating, (0.0)
        end
    end

    def progress_rate(user)
        unless lessons.count.zero?
          (checked_lessons.where(user_id: user).count/ self.lessons_count.to_f) * 100  
        end
    end
end
