require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  def setup
    @course = courses(:endim)
  end

  def test_should_require_name
    @course.name = ''
    assert @course.invalid?
    @course.name = 'Endimensionell analys'
    assert @course.valid?
  end

  def test_should_require_code
    @course.code = ''
    assert @course.invalid?
    @course.code = 'FMAA01'
    assert @course.valid?
  end
end
