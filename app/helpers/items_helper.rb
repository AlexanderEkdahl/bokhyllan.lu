require 'uri'

module ItemsHelper
  def item_properties(item)
    item.properties.each do |key, value|
      value = value.split(/;\s?/)
      key   = t(key, count: value.length)
      yield(key, value.to_sentence)
    end
  end

  def alternative_link(item)
    site = URI(item.alternative).host.split('.')[-2].humanize
    link_to(site, item.alternative, title: item.name)
  end
end
