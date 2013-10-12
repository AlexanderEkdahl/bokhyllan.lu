class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy

  def email
    self[:email].blank? ? "#{login}@student.lu.se" : self[:email]
  end

  def name
    self[:name].blank? ? email : self[:name]
  end

  alias_method :to_s, :name
end
