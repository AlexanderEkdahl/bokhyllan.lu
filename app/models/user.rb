class User < ActiveRecord::Base
  include Verifiable

  require 'bcrypt'

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

  def verify!
    update_attribute(:verified, true)
  end

  has_many :orders, dependent: :destroy
  has_many :available_orders, -> { where(buyer_id: nil) }, class_name: 'Order'
  has_many :buying_orders, class_name: 'Order', foreign_key: 'buyer_id'

  PROPERTIES_KEYS = [:name, :phone]
  store_accessor :properties, PROPERTIES_KEYS

  def email
    "#{login}@student.lu.se"
  end

  def to_s
    return name unless name.blank?
    return email
  end

  def encrypt_password
    self.password_digest = BCrypt::Password.create(@password) unless @password.blank?
  end

  def authenticate(unencrypted_password)
    BCrypt::Password.new(password_digest) == unencrypted_password
  end
end
