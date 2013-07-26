require 'test_helper'

class ItemsHelperTest < ActionView::TestCase
  def setup
    @item = build(:item)
  end

  def test_alternative_link
    @item.name = "Endimensionell analys"
    @item.alternative = 'http://www.bokia.se/endimensionell-analys-7553779'
    assert_equal('<a href="http://www.bokia.se/endimensionell-analys-7553779" title="Endimensionell analys">Bokia</a>', alternative_link(@item))
  end
end
