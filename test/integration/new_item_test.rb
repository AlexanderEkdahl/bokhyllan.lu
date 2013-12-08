require 'test_helper'

class NewItemTest < ActionDispatch::IntegrationTest
  def test_creating_an_item
    # Requires Algolia
    # assert_difference(-> { Item.count }) do
    #   visit_and_sign_in(new_item_path)
    #   fill_in('item[name]', with: 'Bibeln')
    #   click_button('Spara')
    # end
  end
end
