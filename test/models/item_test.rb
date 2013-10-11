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
end
