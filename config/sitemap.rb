# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://bokhyllan.lu"

SitemapGenerator::Sitemap.create do
  Item.find_each do |item|
    add item_path(item), changefreq: 'daily', lastmod: item.updated_at, priority: 0.7
  end

  Order.find_each do |order|
    add item_order_path(order.item, order), changefreq: 'daily', lastmod: order.updated_at
  end
end
