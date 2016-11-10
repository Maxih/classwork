class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 3, allow_nil: true }

  after_initialize :ensure_session_token

  attr_reader :password

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)

    (user && user.is_password?(password)) ? user : nil
  end

  def self.find_by_session_token(session_token)
    User.find_by(session_token: session_token)
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
    self.session_token
  end
end
