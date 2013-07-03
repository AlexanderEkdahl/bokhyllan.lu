require 'test_helper'

class OrderTest < ActionDispatch::IntegrationTest
  def test_selling_and_buying
    item   = create(:item)
    seller = sign_in_and_verify(create(:user))
    buyer  = sign_in_and_verify(create(:user))

    assert_difference(-> { Order.count }, +1) do
      seller.post_via_redirect(item_orders_path(item), order: { price: 200, quality: 2 })
      seller.assert_response(:success)
      assert_equal(item_path(item), seller.path)
      seller.assert_select(".orders table tbody tr", 1)
    end

    order = item.orders.first
    buyer.post_via_redirect(buy_item_order_path(item, order))
    buyer.assert_response(:success)

    buyer.get(item_path(item))
    buyer.assert_select(".orders table tbody tr", 0)
  end
end
