class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:trackable, :confirmable
  has_many :courses, dependent: :destroy
  rolify
  def username
      self.email.split(/@/).first
  end

  after_create :assign_default_role
  def assign_default_role
    user = User.find_by!(email: 'onuhenry24@gmail.com')
    if user.email == 'onuhenry24@gmail.com'
    self.add_role(:admin) if self.roles.blank?
    self.add_role(:teacher) 
    self.add_role(:student) 
    else
      self.add_role(:teacher) if self.roles.blank?
      self.add_role(:student) #if you want any user to create course
    end
  end
    
end
