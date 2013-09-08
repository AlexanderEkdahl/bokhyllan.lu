class Item < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  has_many :orders, dependent: :destroy
  accepts_nested_attributes_for :orders, reject_if: proc { |attributes| attributes['price'].blank? }

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }

  PROPERTIES_KEYS = [:courses, :authors, :program]
  store_accessor :properties, PROPERTIES_KEYS

  def tokens
    [*name.split, *properties.values.map { |v| v.split(/[\s;]\s?/) }.flatten]
  end

  def self.last_modified
    maximum(:updated_at)
  end

  def self.search(query)
    tire.search("#{query}*")
  end

  def to_indexed_json
    {
      :name    => name,
      :authors => properties['authors'],
      :courses => properties['courses']
    }.to_json
  end

  def self.merge(from_id, to_id)
    from = Item.find(from_id)

    from.orders.each do |order|
      order.item_id = to_id
      order.save
    end
  end
end
