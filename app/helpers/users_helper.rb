module UsersHelper
  def tel_to(phone)
    link_to(phone, "tel://#{phone}")
  end

  def contact_information(user)
    hash         = {}
    hash[:name]  = user.name unless user[:name].blank?
    hash[:phone] = tel_to(user.phone) unless user.phone.blank?
    hash[:email] = mail_to(user.email)
    hash
  end

  def contact_information_with_keys(user)
    contact_information(user).each do |key, value|
      yield(t("activerecord.attributes.user.#{key}"), value)
    end
  end

  def user_order_row(order)
    link = [order.item, order]

    row(link_to(order.item.name, link),
        link_to("#{order.price}kr", link),
        link_to(stars(order.quality), link, class: 'quality'),
        button_to("&#xE002;".html_safe, [order.item, order].compact, method: :delete, class: 'remove'))
  end
end
