class User < ActiveRecord::Base
  validates :full_name, :location, presence: true
  validates :bio, length: { minimum: 30 }, allow_blank: false
  validates :password, presence: true, confirmation: true
  validates :email, presence: true,
                    format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ },
                    uniqueness: true
end
