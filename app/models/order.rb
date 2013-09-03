class Order < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :item, touch: true

  validates :price, numericality: { only_integer: true, greater_than: 0, less_than: 1000 }
  validates :quality, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }
  validates :user_id, presence: true

  default_scope { order('price ASC, quality DESC') }
end
