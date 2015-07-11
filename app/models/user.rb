class User < ActiveRecord::Base
  has_many :rooms

  has_secure_password

  validates :full_name, :location, presence: true
  validates :bio, length: { minimum: 30 }, allow_blank: false
  validates :email, presence: true,
                    format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ },
                    uniqueness: true

  scope :confirmed, -> { where.not(confirmed_at: nil) }

  before_create do |user|
    user.confirmation_token = SecureRandom.urlsafe_base64
  end

  def confirm!
    return if confirmed?

    self.confirmed_at = Time.now
    self.confirmation_token = ''
    save!
  end

  def confirmed?
    confirmed_at.present?
  end

  def self.authenticate(email, password)
    confirmed.find_by(email: email).try(:authenticate, password)
  end
end
