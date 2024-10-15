class User < ApplicationRecord
  has_secure_password
  before_save :normalize_email
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

  private
  def normalize_email
    self.email = self.email.delete(' ').downcase
  end
end
