class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :item, touch: true

  validates :price, numericality: { only_integer: true, greater_than: 0, less_than: 1000 }
  validates :quality, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }
  validates :user_id, presence: true
  validates :edition, length: { maximum: 25 }

  default_scope { where(archived: false).order('price ASC, quality DESC') }

  def archive
    self.update(archived: true)
  end
end
