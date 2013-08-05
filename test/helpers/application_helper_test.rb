require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  def test_row
    assert_equal('<tr><td>A</td></tr>', row('A'))
    assert_equal('<tr><td>A</td><td></td></tr>', row('A',nil))
    assert_equal('<tr><td>A</td><td>B</td></tr>', row('A','B'))
  end
end
