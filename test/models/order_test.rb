require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @order = orders(:simple)
  end

  def test_should_limit_comment
    @order.edition = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    assert(@order.invalid?)
  end

  def test_should_limit_quality
    @order.quality = 0
    assert(@order.invalid?)
    @order.quality = 4
    assert(@order.invalid?)
    @order.quality = 3
    assert(@order.valid?)
  end

  def test_default_scope_and_archive
    assert Order.all.include?(@order)
    @order.archive
    assert !Order.all.include?(@order)
  end
end
