module ItemsHelper
  def item_courses(item)
    item.courses.map { |course| "#{course.code} - #{course.name}" }.to_sentence
  end

  def item_tags(item)
    item.tags.map { |tag| tag.prepend('#') }.to_sentence
  end

  def item_programs(item)
    item.courses.pluck(:programs).flatten.uniq.sort.to_sentence
  end

  def item_order_row(order)
    link = [order.item, order]
    row(link_to("#{order.price}kr", link),
        link_to(stars(order.quality), link, class: 'quality'),
        link_to("#{order.edition}", link),
        link_to("&#xE001;".html_safe, link, class: 'arrow'))
  end
end
