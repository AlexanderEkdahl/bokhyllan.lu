class Item < ActiveRecord::Base
  searchkick autocomplete: [:name],
             suggest: [:name], special_characters: false,
             synonyms: I18n.t(:synonyms)

  has_many :orders, dependent: :destroy
  accepts_nested_attributes_for :orders, reject_if: proc { |attributes| attributes['price'].blank? }

  has_and_belongs_to_many :courses, -> { uniq }

  validates :name, presence: true, length: { maximum: 100 }

  def course_list
    self.courses.pluck(:code).join('; ')
  end

  def course_list=(new_value)
    self.courses = new_value.scan(/[\wåäö]+/).map { |code| Course.find_by(code: code) }.compact
  end

  def tag_list
    self.tags.map { |tag| "##{tag}" }.join(' ')
  end

  def tag_list=(new_value)
    self.tags = new_value.scan(/[\wåäö]+/)
  end

  def author_list
    self.authors.join('; ')
  end

  def author_list=(new_value)
    self.authors = new_value.split(';').map(&:strip).reject(&:empty?)
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
