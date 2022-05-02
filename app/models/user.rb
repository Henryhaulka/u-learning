class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:trackable, :confirmable,
         :omniauthable, omniauth_providers: [:google_oauth2, :github, :facebook]

  #nullify is used so that when a user deletes their account, their associations
  #still exists
  has_many :courses, dependent: :nullify
  has_many :user_lessons, dependent: :nullify
  has_many :subscriptions, dependent: :nullify
  has_many :comments, dependent: :nullify
  rolify

  include PublicActivity::Model
  tracked only: [:create, :destroy], owner: :itself

  after_create :assign_default_role
  # we didnt user controller cos authenciaction is done by devise
  after_create do
    UserMailer.new_user(self).deliver_now
  end
  
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
 
    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(
           email: data['email'],
           password: Devise.friendly_token[0,20],
           confirmed_at: Time.now #verifies a user that signs up with google
        )
    else
      user.name = access_token.info.name
      user.image = access_token.info.image
      user.provider = access_token.provider
      user.save!
    end
    user
  end

  def calculate_balance
    update_column :course_income, (courses.map(&:income).sum)
    update_column :balance, (course_income - subscription_expenses)
  end

  def calculate_expenses
    update_column :subscription_expenses, (subscriptions.map(&:price).sum)
    update_column :balance, (course_income - subscription_expenses)
  end
  
  
  def username
      self.email.split(/@/).first
  end

  def view(lesson)
    user_view = self.user_lessons.where( lesson_id: lesson.id)
    unless user_view.present?
      # unique user
      self.user_lessons.create(lesson_id: lesson.id)
    else
      #we use .first cos where returns an array
      user_view.first.increment!(:impression)
    end
  end
  

  def buy_a_course(course)
    self.subscriptions.create(course_id: course.id, price: course.price)
  end
  
  def online?
    self.updated_at > 2.minutes.ago
  end
  
  extend FriendlyId
  friendly_id :username, use: :slugged

  private
  def assign_default_role
    if User.count == 1
      self.add_role(:admin) if self.roles.blank?
      self.add_role(:teacher) 
      self.add_role(:student) 
    else
      #self.add_role(:teacher)  #if you want any user to create course
      self.add_role(:student) if self.roles.blank?
    end
  end

  validate :must_have_a_role, on: :update

  def must_have_a_role
    unless roles.present?
      errors.add(:roles, 'User must have a role')
    end
  end  
end
