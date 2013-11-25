xml.instruct!

xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do
  @items.each do |item|
    xml.url do
      xml.loc item_url(item)
      xml.lastmod item.updated_at.strftime("%F")
      xml.changefreq("weekly")
      xml.priority("0.8")
    end

    item.orders.each do |order|
      xml.url do
        xml.loc item_order_url(item, order)
        xml.lastmod order.updated_at.strftime("%F")
        xml.changefreq("monthly")
        xml.priority("0.4")
      end
    end
  end
end
