class User < ApplicationRecord
  has_secure_password
  before_save :normalize_email
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :password, presence: true, length: { minimum: 8 }, message: "must be at least 8 characters long"
  validates :password_confirmation, presence: true, message: "must match password"
  validates :first_name, presence: true, message: "first name is required"
  validates :last_name, presence: true, message: "last name is required"
  
  private
  def normalize_email
    self.email = self.email.delete(' ').downcase
  end
end
