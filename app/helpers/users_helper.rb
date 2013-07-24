module UsersHelper
  def email_with_verification(user)
    return "#{user.email} &#10003;".html_safe if user.verified?
    user.email
  end

  def user_properties(user)
    user.properties.each do |key, value|
      yield(t("activerecord.attributes.order.#{key}"), value) unless value.blank?
    end
  end

  def contact_information(user)
    [user.email, *user.properties.values.reject(&:blank?)].join(" ") unless user.nil?
  end

  def qr(user, size = 100)
    return if user.try(:phone).blank?

    qr_call = "TEL:#{user.phone}"
    qr      = "http://api.qrserver.com/v1/create-qr-code/?data=#{CGI::escape(qr_call)}&size=#{size}x#{size}"
    image_tag(qr, class: "qr", alt: qr_call, size: size)
  end
end
