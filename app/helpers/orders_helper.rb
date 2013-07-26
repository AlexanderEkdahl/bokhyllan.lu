module OrdersHelper
  def stars(quality)
    ("&#9734;&nbsp;" * quality).html_safe unless quality.nil?
  end

  def night?(time = Time.now)
    time.hour > 22 || time.hour < 6
  end

  def other_items(order)
    order.user.orders.available - [order]
  end

  def orders_invalid(order)
    if order.errors.added?(:buyer_id, :taken)
      t(:already_buying, name: order.item.name)
    elsif order.errors.added?(:buyer_id, :invalid)
      t(:cannot_buy_from_self, name: order.item.name)
    end
  end
end
