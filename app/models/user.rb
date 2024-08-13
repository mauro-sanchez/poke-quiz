class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  before_save :downcase_email
  has_many :quizzes

  def downcase_email
    email.downcase!
  end
end
