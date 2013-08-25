# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://bokhyllan.lu"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  Item.find_each do |item|
    add item_path(item), changefreq: 'daily', lastmod: item.updated_at, priority: 0.7
  end

  Order.find_each do |order|
    add item_order_path(order.item, order), changefreq: 'daily', lastmod: order.updated_at
  end
end
