class User < ActiveRecord::Base
  attr_reader :password

  validates :user_name, presence: true, uniqueness: true
  validates :password_digest, presence: {message: "Password cannot be empty"}
  validates :password, length: {minimum: 6, allow_nil: true}

  has_many :cats
  has_many :cat_rental_requests
  has_many :sessions

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by_user_name(user_name)
    user.try(:is_password?, password) ? user : nil
  end
end
