module UsersHelper
  before_save :downcase_email

  def downcase_email
    email.downcase!
  end
end
