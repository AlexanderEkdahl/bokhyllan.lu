module OrdersHelper
  def stars(quality)
    ("&#9734;&nbsp;" * quality).html_safe unless quality.nil?
  end

  def night?(time = Time.now)
    time.hour > 22 || time.hour < 6
  end

  def other_items(order)
    order.user.available_orders - [order]
  end
end
