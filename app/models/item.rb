class Item < ActiveRecord::Base
  searchkick autocomplete: [:name],
             suggest: [:name], special_characters: false

  has_many :orders, dependent: :destroy
  accepts_nested_attributes_for :orders, reject_if: proc { |attributes| attributes['price'].blank? }

  validates :name, presence: true, length: { maximum: 100 }

  PROPERTIES = [:authors, :courses, :program]
  store_accessor :properties, PROPERTIES

  PROPERTIES.each do |property|
    define_method(property) do
      self.properties[property.to_s].try(:split, /;\s?/)
    end
  end

  def tag_list
    self.tags.map { |tag| "##{tag}" }.join(' ')
  end

  def tag_list=(new_value)
    self.tags = new_value.scan(/#?(\w+)/).flatten
  end

  def search_data
    {
      name: name,
      authors: authors,
      courses: courses,
      tags: tags
    }
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def self.merge(from_id, to_id)
    from = Item.find(from_id)

    from.orders.each do |order|
      order.update(item_id: to_id)
    end

    from.reload.destroy
  end
end
