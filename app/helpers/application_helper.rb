module ApplicationHelper
  def row(*values)
    content_tag(:tr) do
      values.map { |x| content_tag(:td, x) }.join.html_safe
    end
  end
end
