module ItemHelper
  def properties(item)
    @item.properties.each do |key, value|
      value = value.split(';')
      key   = t(key)
      key   = value.length > 1 ? key.pluralize.html_safe : key
      yield(key, value.to_sentence)
    end
  end
end
