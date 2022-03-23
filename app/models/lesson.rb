class Lesson < ApplicationRecord
  belongs_to :course, counter_cache: true
  #to update your count_cache(sub) run this in console
  # Course.find_each {|course| Course.reset_counters(course.id, :lessons )}
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_rich_text :content
  validates :title, :content, :course, presence: true
  validates :content, length: {minimum: 10, maximum: 1000 }
  validates :title, length: {minimum: 5, maximum: 50 }
  has_many :user_lessons, dependent: :destroy
  include RankedModel
  ranks :row_order, with_same: :course_id  


  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  
  #converting the public record to title string
  def to_s
    title
  end
  scope :recent_lessons, -> {order(created_at: :desc)}

  def lesson_viewed?(user)
    self.user_lessons.where(user_id: user).present?
  end

  def prev
    # if we are on page 2, find d last lesson less than 2 = 1
    course.lessons.where('row_order < ?', row_order).order(:row_order).last
  end

  def next
    # if we are on page 2, find d first lesson grater than 2 = 3
    course.lessons.where('row_order > ?', row_order).order(:row_order).first
  end
end
