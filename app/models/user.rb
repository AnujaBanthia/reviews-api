class User < ApplicationRecord
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true,
                   uniqueness: true,
                   length: { minimum: 3, maximum: 25 }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: {with: VALID_EMAIL_REGEX}
  validates :role, presence: true
  has_secure_password
  has_many :comments
  has_many :reviews
  has_many :books
  has_many :movies
end
