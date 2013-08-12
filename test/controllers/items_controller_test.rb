require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  def test_index
    get(:index)
    assert_response(:success)
  end

  def test_show
    item = create(:item, id: 1)
    get(:show, id: 1)
    assert_response(:success)
    assert(assigns(:item), item)
  end

  def test_item_routing
    assert_routing('/', controller: 'items', action: 'index')
    assert_routing('/items/1', controller: 'items', action: 'show', id: '1')
  end
end
