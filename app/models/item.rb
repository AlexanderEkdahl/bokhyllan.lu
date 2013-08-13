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

  mapping do
    indexes :id, index: :not_analyzed
    indexes :name, type: :string, boost: 100.0, analyzer: :snowball
  end
end
