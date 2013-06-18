json.array!(@items) do |item|
  json.value item.name
  json.tokens item.tokens
  json.url item_path(item)
end
