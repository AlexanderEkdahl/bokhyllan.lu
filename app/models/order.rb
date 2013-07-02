class Order < ActiveRecord::Base
  belongs_to :user, :touch => true
  belongs_to :item, :touch => true
  belongs_to :buyer, :touch => true, class_name: 'User'

  validates :price, numericality: { only_integer: true, greater_than: 50, less_than: 1000 }
  validates :user_id, presence: true
  validates :buyer_id, uniqueness: { scope: :item_id }, allow_nil: true
  validate { errors.add(:buyer_id) if user_id == buyer_id }

  default_scope { order('price ASC, quality DESC') }
end
