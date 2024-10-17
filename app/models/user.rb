class User < ApplicationRecord
  has_secure_password
  before_save :normalize_email
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :password, presence: true, length: { minimum: 8, message: "must be at least 8 characters long" }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Generate a signed token with 1hr expiration time
  def generate_password_reset_token
    self.class.verifier.generate({user_id: id, expires_at: 1.hour.from_now})
  end

  # Verify the token and return the user
  def self.verify_password_reset_token(token)
    begin
      data = verifier.verify(token)
      return if data.blank? || data[:expires_at] < Time.current

      find_by(id: data[:user_id])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      nil # Invalid token
    end
  end

  private
  # Generates a secret key for signing
  def self.verifier
    ActiveSupport::MessageVerifier.new(Rails.application.secret_key_base, digest: "SHA256")
  end
  
  def normalize_email
    self.email = self.email.delete(' ').downcase
  end

  def password_required?
    new_record? || password.present?
  end
end
