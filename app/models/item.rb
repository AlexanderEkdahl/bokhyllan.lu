class Item < ActiveRecord::Base
  searchkick autocomplete: [:name, :courses, :authors], suggest: [:name]

  has_many :orders, dependent: :destroy
  accepts_nested_attributes_for :orders, reject_if: proc { |attributes| attributes['price'].blank? }

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }

  PROPERTIES_KEYS = [:courses, :authors, :program]
  store_accessor :properties, PROPERTIES_KEYS

  def search_data
    {
      name: name,
      authors: authors.try(:split, /[\s;]\s?/),
      courses: courses.try(:split, /[\s;]\s?/)
    }
  end

  def self.merge(from_id, to_id)
    from = Item.find(from_id)

    from.orders.each do |order|
      order.item_id = to_id
      order.save
    end
  end
end
