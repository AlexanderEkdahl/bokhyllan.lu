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
end
