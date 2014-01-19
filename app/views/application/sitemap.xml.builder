xml.instruct!

xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do
  @items.each do |item|
    xml.url do
      xml.loc item_url(item)
      xml.lastmod item.updated_at.strftime("%F")
      xml.changefreq("weekly")
    end
  end
end
