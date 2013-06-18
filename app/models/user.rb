require 'bcrypt'

class User < ActiveRecord::Base
  attr_reader :password

  validates :login, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 3 }, on: :create

  before_save { login.downcase! }

  has_many :orders
  has_many :buying_orders, class_name: 'Order', foreign_key: 'buyer_id'

  after_create :send_verification_mail

  def self.properties_keys
    [:name, :phone]
  end
  store_accessor :properties, properties_keys

  def email
    "#{login}@student.lu.se"
  end

  def to_s
    return name unless name.blank?
    email
  end

  def self.authenticate(login: raise, password: raise)
    user = find_by(login: login.downcase)

    if user.try(:authenticate, password)
      user
    elsif user.nil?
      create(login: login, password: password)
    end
  end

  def password=(unencrypted_password)
    @password = unencrypted_password
    unless unencrypted_password.blank?
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  def authenticate(unencrypted_password)
    BCrypt::Password.new(password_digest) == unencrypted_password
  end

  def send_verification_mail
    UserMailer.verification_email(self).deliver
  end

  def verification_key
    ActiveSupport::MessageEncryptor
      .new(Rails.application.config.secret_key_base)
      .encrypt_and_sign(id)
  end

  def self.find_by_verification_key(value)
    id = ActiveSupport::MessageEncryptor
      .new(Rails.application.config.secret_key_base)
      .decrypt_and_verify(value)

    find(id)
  rescue ActiveSupport::MessageVerifier::InvalidSignature
  end
end
