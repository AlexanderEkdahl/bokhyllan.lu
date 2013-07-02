require 'test_helper'

class OrdersHelperTest < ActionView::TestCase
  def test_stars
    assert_equal(nil, stars(nil))
    assert_equal('&#9734; ', stars(1))
    assert_equal('&#9734; &#9734; ', stars(2))
  end
end
