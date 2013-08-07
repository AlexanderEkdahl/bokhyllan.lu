class StandardFormBuilder < ActionView::Helpers::FormBuilder
  alias_method :original_text_field, :text_field
  def text_field(lbl, *args)
    label(lbl) +
    original_text_field(lbl, *args)
  end

  alias_method :original_password_field, :password_field
  def password_field(lbl)
    label(lbl) +
    original_password_field(lbl)
  end

  def price
    label(:price) +
    telephone_field(:price)
  end

  def quality(*args)
    label(:quality) +
    @template.content_tag(:div, class: 'quality') do
      radio_button(:quality, "3") +
      label(:quality_3, "&#9733;".html_safe) +
      radio_button(:quality, "2", checked: true) +
      label(:quality_2, "&#9733;".html_safe) +
      radio_button(:quality, "1") +
      label(:quality_1, "&#9733;".html_safe)
    end
  end

  alias_method :original_submit, :submit
  def submit
    original_submit(class: "button")
  end
end
