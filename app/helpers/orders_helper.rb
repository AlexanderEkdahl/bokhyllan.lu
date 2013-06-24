module OrdersHelper
  def stars(quality)
    ("&#9733; " * quality).html_safe unless quality.nil?
  end
end
