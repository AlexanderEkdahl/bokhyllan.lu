class StandardForm < ActionView::Helpers::FormBuilder
  FORM_HELPERS = %w{text_field password_field text_area file_field
                    number_field email_field telephone_field phone_field url_field
                    select collection_select date_select time_select datetime_select}
  STARS = 3
  STAR  = "&#9733;".html_safe

  delegate :content_tag, to: :@template

  FORM_HELPERS.each do |method_name|
    define_method(method_name) do |name, *args|
      options = args.extract_options!
      options[:spellcheck] = false

      if object.respond_to?(:errors) && object.errors.include?(name)
        options[:class] = 'error'
        suffix = object.errors.get(name).to_sentence
      else
        suffix = I18n.t("#{name}_help", default: '')
      end

      label(name) + super(name, options) + content_tag(:span, suffix)
    end
  end

  def price
    telephone_field(:price)
  end

  def quality
    label(:quality) +
    content_tag(:div, class: 'quality') do
      STARS.downto(1).map do |i|
        checked = (STARS / 2.0).ceil == i
        radio_button(:quality, i, checked: checked) + label("quality_#{i}", STAR)
      end.join.html_safe
    end
  end

  def submit
    super(class: "button")
  end
end
