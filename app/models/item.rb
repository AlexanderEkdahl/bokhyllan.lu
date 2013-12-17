class Item < ActiveRecord::Base
  include AlgoliaSearch

  algoliasearch per_environment: true do
    attribute :name, :tags, :authors, :url, :orders_count
    attribute :courses do
      courses.map(&:to_s)
    end

    hitsPerPage 5
    queryType :prefixAll
    customRanking ['desc(orders_count)']
    attributesToIndex [:name, :tags, :authors, :courses]
    separatorsToIndex '+'
  end

  after_touch :index!

  has_many :orders, dependent: :destroy
  accepts_nested_attributes_for :orders, reject_if: proc { |attributes| attributes['price'].blank? }

  has_and_belongs_to_many :courses, -> { uniq }

  validates :name, presence: true, length: { maximum: 100 }

  def course_list
    self.courses.pluck(:code).join('; ')
  end

  def course_list=(new_value)
    self.courses = new_value.scan(/[[:alnum:]]+/).map { |code| Course.find_by(code: code.upcase) }.compact
  end

  def tag_list
    self.tags.map { |tag| "##{tag}" }.join(' ')
  end

  def tag_list=(new_value)
    self.tags = new_value.scan(/[[:alnum:]]+/)
  end

  def author_list
    self.authors.join('; ')
  end

  def author_list=(new_value)
    self.authors = new_value.split(';').map(&:strip).reject(&:empty?)
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  # should try to inverse the result of to_param
  def self.from_param(x)
    x.scan(/\w+/)[1..-1].join(' ')
  end

  def url
    Rails.application.routes.url_helpers.item_path(self)
  end

  def orders_count
    orders.count
  end

  def self.merge(from_id, to_id)
    from = Item.find(from_id)

    from.orders.each do |order|
      order.update(item_id: to_id)
    end

    from.reload.destroy
  end
end
