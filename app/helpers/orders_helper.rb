module OrdersHelper
  def stars(quality)
    ("&#9734;&nbsp;" * quality).html_safe unless quality.nil?
  end

  def other_items(order)
    order.user.orders - [order]
  end

  def orders_invalid(order)
    if order.errors.added?(:buyer_id, :taken)
      t(:already_buying, name: order.item.name)
    elsif order.errors.added?(:buyer_id, :invalid)
      t(:cannot_buy_from_self, name: order.item.name)
    end
  end

  def order_row(order)
    link = [order.item, order]
    row(link_to(order.item.name, link),
        link_to("#{order.price}kr", link, data: { :'sort-value' => order.price }),
        link_to(stars(order.quality), link, data: { :'sort-value' => order.quality }, class: 'quality'),
        link_to("&#xE001;".html_safe, link, class: 'arrow'))
  end
end
