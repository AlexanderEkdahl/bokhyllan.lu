module ItemsHelper
  require 'uri'

  def item_properties(item)
    item.properties.each do |key, value|
      next if value.blank?
      value = value.split(/;\s?/)
      key   = t(key, count: value.length)
      yield(key, value.to_sentence)
    end
  end

  def alternative_link(item)
    site = URI(item.alternative).host.split('.')[-2].humanize
    link_to(site, item.alternative, title: item.name)
  end

  def item_order_row(order)
    link = [order.item, order]
    row(link_to("#{order.price}kr", link, data: { :'sort-value' => order.price }),
        link_to(stars(order.quality), link, data: { :'sort-value' => order.quality }, class: 'quality'),
        link_to("&#xE001;".html_safe, link, class: 'arrow'))
  end
end
