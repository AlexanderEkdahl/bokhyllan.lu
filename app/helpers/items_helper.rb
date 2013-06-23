module ItemsHelper
  def properties(item)
    @item.properties.each do |key, value|
      value = value.split(/;\s?/)
      key   = value.length > 1 ? t(key.pluralize) : t(key)
      yield(key, value.to_sentence)
    end
  end
end
