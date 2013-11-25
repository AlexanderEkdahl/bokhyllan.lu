require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  def test_sitemap
    get(:sitemap, format: :xml)
    assert_response(:success)
    assert(assigns(:items))

    assert_raises(ActionView::MissingTemplate) do
      get(:sitemap, format: :html)
    end
  end
end
