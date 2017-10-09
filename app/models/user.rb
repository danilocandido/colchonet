class User < ApplicationRecord
  EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  has_secure_password

  validates :email, :full_name, :location, presence: true
  validates :email, uniqueness: true
  validates :bio, length: {minimum: 30}, allow_blank: false

  validate :email_format

  scope :confirmed, -> { where.not(confirmed_at: nil) }

  before_create do |user|
    user.confirmation_token = SecureRandom.urlsafe_base64
  end

  def confirm!
    return if confirmed?
    
    self.confirmed_at = Time.current
    self.confirmation_token = ''
    save!
  end

  def confirmed?
    confirmed_at.present?
  end

  def self.authenticate(email, password)
    user = confirmed.find_by(email: email)
    if user.present?
      user.authenticate(password)
    end
  end

  private
    def email_format
      errors.add(:email, :invalid) unless email.match(EMAIL_REGEXP)
    end
    
end
