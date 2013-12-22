require 'test_helper'

class NewOrderFlowTest < ActionDispatch::IntegrationTest
  def test_creating_a_new_order
    item = items(:linux)

    visit(item_path(item))

    assert(page.has_content?('Ingen säljer Linux Kernel Development.'))
    assert(page.has_content?('Du måste vara inloggad för att sälja Linux Kernel Development.'))

    sign_in

    assert(page.has_content?('Ny annons'))

    assert_difference(-> { Order.count }) do
      fill_in('order_price', with: '50')
      fill_in('order_edition', with: 'Den röda')
      click_button('Spara')
    end

    assert(page.has_content?('50kr'))
    assert(page.has_content?('Den röda'))

    visit(user_path)
    assert(page.has_content?('Aktiva annonser'))
    assert(page.has_content?('Linux Kernel Development'))
    assert(page.has_content?('50kr'))
  end
end
