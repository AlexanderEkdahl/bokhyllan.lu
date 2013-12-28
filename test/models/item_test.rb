require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @item = items(:pvg)
  end

  def test_should_require_name
    @item.name = ''
    assert @item.invalid?
    @item.name = 'Endimensionell Analys'
    assert @item.valid?
  end

  def test_item_tag_list
    @item.tag_list = "#funken#linalg##"
    assert_equal %w{funken linalg}, @item.tags
    assert_equal "#funken #linalg", @item.tag_list
    @item.tag_list = "pvg"
    assert_equal %w{pvg}, @item.tags
    assert_equal "#pvg", @item.tag_list
    @item.tag_list = "dålig bok"
    assert_equal %w{dålig bok}, @item.tags
  end

  def test_item_author_list
    @item.author_list = "Alexander Ekdahl; Keff;;"
    assert_equal ["Alexander Ekdahl", "Keff"], @item.authors
    assert_equal "Alexander Ekdahl; Keff", @item.author_list
    @item.author_list = "Käffö ; Författare;"
    assert_equal ["Käffö", "Författare"], @item.authors
    assert_equal "Käffö; Författare", @item.author_list
  end

  def test_item_course_list
    @item.course_list = "EDA260; FMAA01"
    assert @item.courses.include?(courses(:EDA260))
    assert @item.courses.include?(courses(:FMAA01))
    @item.course_list = ""
    assert_equal [], @item.courses
    # Fix these issues
    # @item.course_list = "EDA260; EDA260;Keff;"
    # assert_equal [courses(:EDA260)], @item.courses
    # assert_equal "EDA260", @item.course_list
  end

  def test_item_should_find_by_lowercase_courses
    @item.course_list = "fmaa01"
    assert @item.courses.include?(courses(:FMAA01))
    assert_equal "FMAA01", @item.course_list
  end

  def test_item_from_param
    assert_equal "endimensionell analys", Item.from_param('223-endimensionell-analys')
    assert_equal "", Item.from_param('32')
  end
end
