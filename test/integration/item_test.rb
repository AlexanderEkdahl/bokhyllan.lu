# require 'test_helper'

# class OrderTest < ActionDispatch::IntegrationTest
#   def test_creating_an_item
#     seller = sign_in_and_verify(create(:user))

#     assert_difference(-> { Item.count }, +1) do
#       seller.post_via_redirect(items_path, item: { name: 'Bibeln' })
#       seller.assert_response(:success)
#     end
#   end
# end
