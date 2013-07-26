class Item < ActiveRecord::Base
  validates :name, presence: true

  has_many :orders, dependent: :destroy

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
