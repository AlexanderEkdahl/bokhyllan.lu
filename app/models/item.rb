class Item < ActiveRecord::Base
  validates :name, presence: true

  has_many :orders, -> { where(buyer_id: nil) }

  def cheapest
    orders.first.try(:price)
  end

  def tokens
    [*name.split, *properties.values.map { |v| v.split(/[\s;]\s?/) }.flatten]
  end
end
