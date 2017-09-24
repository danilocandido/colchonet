class User < ApplicationRecord
  EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  validates :email, :full_name, :location, presence: true
  validates :email, uniqueness: true
  validates :bio, length: {minimum: 30}, allow_blank: false

  has_secure_password

  validate :email_format

  private
    def email_format
      errors.add(:email, :invalid) unless email.match(EMAIL_REGEXP)
    end
end
