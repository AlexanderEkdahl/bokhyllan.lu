module ItemsHelper
  def item_highlight(item, attribute)
    value = item.try(:highlight_result).try(:[], attribute.to_s)

    if value.kind_of?(Array)
      value.map { |v| v['value'] }
    else
      value.try(:[], 'value').try(:html_safe) || item.send(attribute)
    end
  end

  def item_authors(item)
    item_highlight(item, :authors).to_sentence.html_safe
  end

  def item_courses(item)
    item_highlight(item, :courses).map(&:to_s).join('<br>').html_safe
  end

  def item_tags(item)
    item.tags.map { |tag| tag.prepend('#') }.join(' ')
  end

  def item_programs(item)
    item.courses.map(&:programs).flatten.uniq.sort.to_sentence
  end

  def item_name(item)
    item_highlight(item, :name)
  end

  def generate_item_keywords(item)
    keywords(item.courses.pluck(:code, :name).flatten.uniq + t(:default_tags))
  end

  def generate_item_description(item)
    val = "#{t("activerecord.attributes.item.author_list")}: #{item.authors.join(' ')}, " +
          "#{t("activerecord.attributes.item.course_list")}: #{item.courses.map(&:to_s).join(' ')}"
    description(truncate(val, length: 150))
  end
end
