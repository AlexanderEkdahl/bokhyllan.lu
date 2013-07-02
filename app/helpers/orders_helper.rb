module OrdersHelper
  def stars(quality)
    ("&#9734; " * quality).html_safe unless quality.nil?
  end
end
