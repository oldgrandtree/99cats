class User < ActiveRecord::Base
  attr_reader :password

  validates :user_name, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: {message: "Password cannot be empty"}
  validates :password, length: {minimum: 6, allow_nil: true}

  before_validation :ensure_session_token

  has_many :cats
  has_many :cat_rental_requests

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
  end

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

  private

  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end
end
