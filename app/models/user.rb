class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true
  validates :username, uniqueness: true
  before_save :downcase_email

  def downcase_email
    email.downcase!
  end
end
