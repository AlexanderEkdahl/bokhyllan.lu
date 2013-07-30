module UsersHelper
  def email_with_verification(user)
    return "#{user.email} &#10003;".html_safe if user.verified?
    user.email
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
    qr      = "http://api.qrserver.com/v1/create-qr-code/?data=#{CGI::escape(qr_call)}&size=#{size}x#{size}"
    image_tag(qr, class: "qr", alt: qr_call, size: size.to_s)
  end
end
