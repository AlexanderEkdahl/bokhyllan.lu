module OrdersHelper
  def stars(quality)
    ("&#9734;&nbsp;" * quality).html_safe unless quality.nil?
  end

  def other_items(order)
    order.user.orders - [order]
  end

  def order_row(order)
    link = [order.item, order]
    row(link_to(order.item.name, link),
        link_to("#{order.price}kr", link),
        link_to(stars(order.quality), link, class: 'quality'),
        link_to("&#xE001;".html_safe, link, class: 'arrow'))
  end
end
