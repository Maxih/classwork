class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true
  validates :password_digest, presence: true
  # validates :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 3, allow_nil: true }
  validates :token, presence: true, uniqueness: true

  after_initialize :ensure_session_token


  has_many :requests,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "CatRentalRequest"

  has_many :cats,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "Cat"

  has_many :sessions,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "Session"

  attr_reader :password
  attr_accessor :token


  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    (user && user.is_password?(password)) ? user : nil
  end

  def ensure_session_token
    unless self.token
      self.token = self.class.generate_session_token
    end

    # @session = Session.new(user_id: self.id, token: self.class.generate_session_token)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!

    session = Session.find_by(token: self.token)
    session ||= Session.new(user_id: self.id)

    session.token = User.generate_session_token
    session.save

    session.token

    # self.session_token = session.token
    # self.save
    # self.session_token
  end


end
