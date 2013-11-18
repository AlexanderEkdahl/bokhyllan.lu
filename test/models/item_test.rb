require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @item = build(:item)
  end

  def test_should_require_name
    @item.name = ''
    assert @item.invalid?
    @item.name = 'Endimensionell Analys'
    assert @item.valid?
  end

  def test_item_tag_list
    @item = items(:pvg)
    @item.tag_list = "#funken #linalg"
    assert %w{funken linalg}, @item.tags
    assert "#funken #linalg", @item.tag_list
    @item.tag_list = "pvg"
    assert %w{pvg}, @item.tags
    assert "#pvg", @item.tag_list
  end
end
