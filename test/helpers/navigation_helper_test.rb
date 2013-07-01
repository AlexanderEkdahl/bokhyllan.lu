require 'test_helper'

class NavigationHelperTest < ActionView::TestCase
  def test_nav
    assert_equal('', nav())
    assert_equal('A', nav('A'))
    assert_equal('A', nav('A', nil))
    assert_equal('A &middot; B', nav('A', 'B'))
    assert_equal('A &middot; B', nav('A', nil, 'B'))
  end
end
