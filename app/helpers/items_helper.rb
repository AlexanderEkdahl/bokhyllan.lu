module ItemsHelper
  def properties(item)
    @item.properties.each do |key, value|
      value = value.split(/;\s?/)
      key   = t(key, count: value.length)
      yield(key, value.to_sentence)
    end
  end
end
