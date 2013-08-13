require 'test_helper'

class OrdersHelperTest < ActionView::TestCase
  def test_stars
    assert_equal(nil, stars(nil))
    assert_equal('&#9734;&nbsp;', stars(1))
    assert_equal('&#9734;&nbsp;&#9734;&nbsp;', stars(2))
  end
end
