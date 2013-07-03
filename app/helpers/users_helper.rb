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
end
