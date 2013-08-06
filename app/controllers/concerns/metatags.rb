module Metatags
  extend ActiveSupport::Concern

  def self.default_tags
    I18n.t(:default_tags)
  end
end
