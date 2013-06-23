class User < ActiveRecord::Base
  attr_accessor :password

  validates :login, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 3 }, if: :password_required?

  before_validation :normalize_login
  before_save :encrypt_password

  def normalize_login
    login.downcase!
    login.gsub!(/@.*/, '')
  end

  attr_accessor :current_password
  validate :validate_current_password, :on => :update, if: :password_required?

  def password_required?
    new_record? || !password.blank?
  end

  def validate_current_password
    errors.add(:current_password) unless authenticate(current_password)
  end

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

  def encrypt_password
    self.password_digest = BCrypt::Password.create(@password) unless @password.blank?
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
