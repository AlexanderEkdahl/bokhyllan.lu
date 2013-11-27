class Course < ActiveRecord::Base
  validates :name, presence: true
  validates :code, presence: true

  has_and_belongs_to_many :items
end
