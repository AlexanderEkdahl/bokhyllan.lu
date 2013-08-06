require 'securerandom'

class User < ActiveRecord::Base
  include Verifiable

  attr_accessor :password

  validates :login, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-z]{3}[0-9]{2}[a-z]{3}\z/ }
  validates :password, presence: true, length: { minimum: 3 }, if: :password_required?

  before_save :encrypt_password

  def self.find_or_create_by_login(login)
    login.downcase!
    login.gsub!(/@.*/, '')
    User.find_or_create_by(login: login)
  end

  attr_accessor :current_password
  validate :validate_current_password, :on => :update, if: :password_required?

  def password_required?
    new_record? || !password.blank?
  end

  def validate_current_password
    errors.add(:current_password) unless authenticate(current_password)
  end

  def verify!
    update_attribute(:verified, true)
  end

  has_many :orders, dependent: :destroy
  has_many :buying_orders, class_name: 'Order', foreign_key: 'buyer_id'

  def email
    "#{login}@student.lu.se"
  end

  def to_s
    return name unless name.blank?
    return email
  end
  # alias :username

  def reset_password
    self.password = SecureRandom.hex(4)
    self.save(validate: false)
    self.password
  end

  def encrypt_password
    self.password_digest = BCrypt::Password.create(@password) unless @password.blank?
  end

  def authenticate(unencrypted_password)
    BCrypt::Password.new(password_digest) == unencrypted_password
  end

  def traits
    { email: email, name: name, phone: phone, created: created_at, verified: verified }.reject { |_, value| value.blank? }
  end
end
