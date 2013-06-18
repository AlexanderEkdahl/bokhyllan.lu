class Item < ActiveRecord::Base
  has_many :orders, -> { where(buyer_id: nil) }

  def cheapest
    orders.first.price unless orders.empty?
  end

  def tokens
    [*name.split, *properties.values.map { |v| v.split(/[\s;]\s?/) }.flatten]
  end
end
