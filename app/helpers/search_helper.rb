module SearchHelper
  def search_form
    value     = @item.nil? ? params[:search] : @item.name
    autofocus = value.blank?

    form_tag(root_path, method: :get, class: 'search') do
      label_tag('', '', id: :autocomplete_label) +
      text_field_tag('search', value,
                     id: 'search',
                     autofocus: autofocus,
                     placeholder: t(:search_placeholder),
                     autocomplete: :off,
                     spellcheck: false,
                     data: {
                       remote: autocomplete_items_path(format: :json)
                     }) +
      submit_tag("&#xE006;".html_safe)
    end
  end

  def autocomplete_div
    content_tag(:div) do
      content_tag(:div, '', id: :autocomplete)
    end
  end

  def search_bar
    search_form + autocomplete_div
  end
end
