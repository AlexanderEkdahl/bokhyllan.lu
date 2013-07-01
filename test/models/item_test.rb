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

  def test_tokens
    @item.name = 'Linear Algebra'
    assert_equal(@item.tokens, ['Linear', 'Algebra'])
    @item.properties = { author: 'Alexander Ekdahl;Joacim Åström'}
    assert_equal(@item.tokens, ['Linear', 'Algebra', 'Alexander', 'Ekdahl', 'Joacim', 'Åström'])
    @item.properties = { authors: 'Alexander Ekdahl; Joacim Åström'}
    assert_equal(@item.tokens, ['Linear', 'Algebra', 'Alexander', 'Ekdahl', 'Joacim', 'Åström'])
    @item.properties = { author: 'Alexander Ekdahl; Joacim Åström', course: 'FMA25'}
    assert_equal(@item.tokens, ['Linear', 'Algebra', 'Alexander', 'Ekdahl', 'Joacim', 'Åström', 'FMA25'])
  end
end
