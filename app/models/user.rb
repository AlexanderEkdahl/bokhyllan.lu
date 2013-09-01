class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy

  def email
    "#{login}@student.lu.se"
  end

  def to_s
    return name unless name.blank?
    return email
  end
end
