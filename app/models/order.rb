class Order < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :item, touch: true
  belongs_to :buyer, touch: true, class_name: 'User'

  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 1000 }
  validates :quality, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }
  validates :user_id, presence: true
  validates :buyer_id, uniqueness: { scope: :item_id }, allow_nil: true
  validate { errors.add(:buyer_id) if user_id == buyer_id }

  default_scope { order('price ASC, quality DESC') }
  scope :available, -> { where(buyer_id: nil) }

  def buy(user)
    update_attributes(buyer_id: user.id)
  end

  def cancel_purchase
    update_attributes(buyer_id: nil)
  end
end
