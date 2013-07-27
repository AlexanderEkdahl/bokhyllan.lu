class Item < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  accepts_nested_attributes_for :orders

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }

  PROPERTIES_KEYS = [:courses, :authors]
  store_accessor :properties, PROPERTIES_KEYS

  def tokens
    [*name.split, *properties.values.map { |v| v.split(/[\s;]\s?/) }.flatten]
  end

  def self.last_modified
    maximum(:updated_at)
  end

  def self.search(search)
    where('name ILIKE ?', "%#{search}%")
  end
end
