module ApplicationHelper
  def row(*values)
    content_tag(:tr) do
      values.map { |x| content_tag(:td, x) }.join.html_safe
    end
  end

  def standard_form_for(name, *args, &block)
    options = args.extract_options!

    form_for(name, *(args << options.merge(builder: StandardForm, html: { class: 'form' })), &block)
  end

  def search_bar(value = params[:search])
    render('search', value: value)
  end
end
