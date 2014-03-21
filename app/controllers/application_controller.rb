class ApplicationController < ActionController::Base
  include Authentication
  include UserAgent

  protect_from_forgery with: :exception

  add_flash_types :success

  before_filter :set_no_cache

  def sitemap
    @items = Item.all
  end

  def about
  end

  def set_no_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "0"
  end
end
