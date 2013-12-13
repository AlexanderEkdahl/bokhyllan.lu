require 'test_helper'

class ItemsHelperTest < ActionView::TestCase
  def setup
    @pvg = items(:pvg)
    @endim = items(:endim)
  end

  def test_item_tags
    assert "#pvg", item_tags(@pvg)
  end

  def test_item_courses
    assert_equal "EDA260 - Programvaruutveckling i grupp – projekt", item_courses(@pvg)
    assert_equal "FMAA01 - Endimensionell analys<br>FMA645 - Endimensionell analys", item_courses(@endim)
  end

  def test_item_programs
    assert_equal %w{C4 D2 E4 F4 Pi4}.to_sentence, item_programs(@pvg)
  end
end
