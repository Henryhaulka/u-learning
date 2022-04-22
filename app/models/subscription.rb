class Subscription < ApplicationRecord
  belongs_to :course, counter_cache: true# to track when a sub is deleted or added to a course
  #to update your count_cache(sub) run this in console
  # Course.find_each {|course| Course.reset_counters(course.id, :subscriptions )}
  belongs_to :user, counter_cache: true # to track when a sub is deleted or added relating to a user
    # User.find_each {|user|User.reset_counters(user.id, :subscriptions )}
  validates :user, :course, presence: true

  #this code ensures that a user subcribe to a course only once
  # hence can't subcribe to same course twice 
  validates_uniqueness_of :user_id, scope: :course_id
  validates_uniqueness_of :course_id, scope: :user_id

  #Scopes
  scope :pending_review, -> { where(rating: [0,nil, ""], review: [0,nil, ""])}
  scope :reviewed, -> { where.not(rating: [0,nil, ""], review: [0,nil, ""])}
  scope :recent, -> {order(created_at: :desc)}
  scope :limiter, -> {limit(3)}
  scope :rater, -> {order(rating: :desc)}

  validates_presence_of :rating, if: :review?
  validates_presence_of :review, if: :rating?

  extend FriendlyId
  friendly_id :to_s, use: :slugged

  def to_s
    user.username + "| "  + course.title
  end

  after_save do
    unless rating.nil? || rating.zero?
      course.update_rating
    end
  end

  # def to_s
  #   course.title + user.username
  # end

  after_destroy do
    course.update_rating
  end

  after_create :calculate_balance
  after_destroy :calculate_balance

  def calculate_balance
    course.calculate_income
    user.calculate_expenses
  end
  


  validate :cant_subscribe_to_own_course
  protected

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  def cant_subscribe_to_own_course
    if self.new_record?
          if  self.user_id == self.course.user.id
            errors.add(:base, "You can't subscribe to your own course")
          end
    end
  end
  
end
