require 'test_helper'

class ItemsHelperTest < ActionView::TestCase
  def setup
    @item = items(:pvg)
  end

  def test_item_tags
    assert "#pvg", item_tags(@item)
  end
end
