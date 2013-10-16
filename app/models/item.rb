class Item < ActiveRecord::Base
  searchkick autocomplete: [:name, :courses, :authors], suggest: [:name]

  has_many :orders, dependent: :destroy
  accepts_nested_attributes_for :orders, reject_if: proc { |attributes| attributes['price'].blank? }

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }

  PROPERTIES = [:courses, :authors, :program]
  store_accessor :properties, PROPERTIES

  PROPERTIES.each do |property|
    define_method(property) do
      self.properties[property.to_s].try(:split, /;\s?/)
    end
  end

  def search_data
    {
      name: name,
      authors: authors.try(:map, &:split),
      courses: courses.try(:map, &:split)
    }
  end

  def self.merge(from_id, to_id)
    from = Item.find(from_id)

    from.orders.each do |order|
      order.update(item_id: to_id)
    end

    from.destroy
  end
end
