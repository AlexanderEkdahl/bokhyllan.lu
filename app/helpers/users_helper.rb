module UsersHelper
  def email_with_verification(user)
    return user.email if user.verified?
    t(:email_not_verified, email: user.email)
  end

  def contact_information(user)
    { email: mail_to(user.email), name: user.name, phone: user.phone }.reject { |_, value| value.blank? }
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
    image_tag(qr_url, class: "qr", alt: qr_call, size: size.to_s)
  end

  def user_order_row(order, target, method = nil)
    link = [order.item, order]

    row(link_to(order.item.name, link),
        link_to("#{order.price}kr", link, data: { :'sort-value' => order.price }),
        link_to(stars(order.quality), link, data: { :'sort-value' => order.quality }, class: 'quality'),
        contact_information_without_keys(target),
        qr(target),
        button_to("&#xE002;".html_safe, [method, order.item, order].compact, method: :delete, form_class: 'remove'))
  end
end
