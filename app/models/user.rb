class User < ApplicationRecord
  has_secure_password
  before_save :normalize_email
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :password, presence: true, length: { minimum: 8, message: "must be at least 8 characters long" }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  private
  def normalize_email
    self.email = self.email.delete(' ').downcase
  end

  def password_required?
    new_record? || password.present?
  end
end
