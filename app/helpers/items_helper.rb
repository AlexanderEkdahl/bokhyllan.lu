module ItemsHelper
  require 'uri'

  def item_tags(item)
    item.tags.map { |tag| tag.prepend('#') }.to_sentence
  end

  def item_properties(item)
    Item::PROPERTIES.each do |key|
      value = item.send(key)
      next if value.blank?
      key = t(key, count: value.length)
      yield(key, value.to_sentence)
    end
    yield(t(:isbn), item.isbn) unless item.isbn.blank?
    yield(t("activerecord.attributes.item.tags"), item_tags(item)) unless item.tags.empty?
  end

  def item_order_row(order)
    link = [order.item, order]
    row(link_to("#{order.price}kr", link),
        link_to(stars(order.quality), link, class: 'quality'),
        link_to("#{order.edition}", link),
        link_to("&#xE001;".html_safe, link, class: 'arrow'))
  end
end
