module OrdersHelper
  def stars(quality)
    ("&#9734; " * quality).html_safe unless quality.nil?
  end

  def night?(time = Time.now)
    time.hour > 22 || time.hour < 6
  end
end
