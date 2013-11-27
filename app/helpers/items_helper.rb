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

  def item_i18n_t(key)
    t("activerecord.attributes.item.#{key}")
  end

  def item_properties(item)
    yield(item_i18n_t(:author_list), item.authors.to_sentence) unless item.authors.empty?
    yield(item_i18n_t(:course_list), item_courses(item)) unless item.courses.empty?
    yield(item_i18n_t(:program_list), item_programs(item)) unless item_programs(item).blank?
    yield(item_i18n_t(:isbn), item.isbn) unless item.isbn.blank?
    yield(item_i18n_t(:tag_list), item_tags(item)) unless item.tags.empty?
  end

  def item_order_row(order)
    link = [order.item, order]
    row(link_to("#{order.price}kr", link),
        link_to(stars(order.quality), link, class: 'quality'),
        link_to("#{order.edition}", link),
        link_to("&#xE001;".html_safe, link, class: 'arrow'))
  end
end
