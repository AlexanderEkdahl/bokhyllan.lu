require 'test_helper'

class OrdersHelperTest < ActionView::TestCase
  def test_stars
    assert_equal(nil, stars(nil))
    assert_equal('&#9734; ', stars(1))
    assert_equal('&#9734; &#9734; ', stars(2))
  end

  def test_night?
    assert(night?(Time.new(1988, 1, 1, 23, 30)), 'Should be night time')
    assert(!night?(Time.new(1988, 1, 1, 12, 30)), 'Should be day time')
  end
end
