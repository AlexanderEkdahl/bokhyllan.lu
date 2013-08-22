module UsersHelper
  def email_with_verification(user)
    return user.email if user.verified?
    t(:email_not_verified, email: user.email)
  end

  def tel_to(phone)
    link_to(phone, "tel:#{phone}")
  end

  def contact_information(user)
    { name: user.name, phone: tel_to(user.phone), email: mail_to(user.email) }.reject { |_, value| value.blank? }
  end

  def contact_information_with_keys(user)
    contact_information(user).each do |key, value|
      yield(t("activerecord.attributes.user.#{key}"), value)
    end
  end

  def contact_information_without_keys(user)
    contact_information(user).values.join(" ").html_safe unless user.nil?
  end

  def qr(user, size = 100)
    return if user.try(:phone).blank?

    qr_call = "TEL:#{user.phone}"
    qr_url  = "http://api.qrserver.com/v1/create-qr-code/?data=#{CGI::escape(qr_call)}&size=#{size}x#{size}"
    image_tag(qr_url, alt: qr_call, size: size.to_s)
  end

  def user_order_row(order)
    link = [order.item, order]

    row(link_to(order.item.name, link),
        link_to("#{order.price}kr", link, data: { :'sort-value' => order.price }),
        link_to(stars(order.quality), link, data: { :'sort-value' => order.quality }, class: 'quality'),
        button_to("&#xE002;".html_safe, [order.item, order].compact, method: :delete, class: 'remove'))
  end
end
