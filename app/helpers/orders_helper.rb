module OrdersHelper
  def stars(quality)
    ("&#9734;&nbsp;" * quality).html_safe unless quality.nil?
  end

  def other_items(order)
    order.user.orders - [order]
  end

  def order_remove_button(order)
    button_to('', [order.item, order], method: :delete, class: 'remove', onclick: "return confirm('#{t(:confirm_order_removal)}');")
  end
end
