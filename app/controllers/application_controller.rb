class ApplicationController < ActionController::Base
  include Authentication
  include Analytics

  protect_from_forgery with: :exception

  add_flash_types :success
end
