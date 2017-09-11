class User < ApplicationRecord
  EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  validates :email, :full_name, :location, :password, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: true
  validates :bio, length: {minimum: 30}, allow_blank: false

  validate :email_format

  private
    def email_format
      errors.add(:email, :invalid) unless email.match(EMAIL_REGEXP)
    end
end
