class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:trackable, :confirmable
  has_many :courses, dependent: :destroy
  rolify
  after_create :assign_default_role

  def username
      self.email.split(/@/).first
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
