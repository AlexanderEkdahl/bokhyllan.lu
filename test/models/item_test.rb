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
    @item.tag_list = "#funken #linalg ##"
    assert_equal %w{funken linalg}, @item.tags
    assert_equal "#funken #linalg", @item.tag_list
    @item.tag_list = "pvg"
    assert_equal %w{pvg}, @item.tags
    assert_equal "#pvg", @item.tag_list
  end

  def test_item_author_list
    @item.author_list = "Alexander Ekdahl; Keff;;"
    assert_equal ["Alexander Ekdahl", "Keff"], @item.authors
    assert_equal "Alexander Ekdahl; Keff", @item.author_list
    @item.author_list = "Keff ; Författare;"
    assert_equal ["Keff", "Författare"], @item.authors
    assert_equal "Keff; Författare", @item.author_list
  end

  def test_item_course_list
    assert_equal [], @item.courses
    @item.course_list = "EDA260; FMAA01"
    assert @item.courses.include?(courses(:pvg))
    assert @item.courses.include?(courses(:endim))
    @item.course_list = ""
    assert_equal [], @item.courses
    @item.course_list = "EDA260; EDA260;Keff;"
    assert_equal [courses(:pvg)], @item.courses
  end
end
