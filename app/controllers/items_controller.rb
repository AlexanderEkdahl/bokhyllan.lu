class ItemsController < ApplicationController
  def index
    fresh_when(true, public: true)
  end

  def show
    @item  = Item.find(params[:id])
    @order = Order.new
    fresh_when(@item, public: true)
  end

  def typeahead
    @items = Item.all
    fresh_when(last_modified: Item.last_modified, public: true)
    expires_in(3.hours, public: true)
  end
end
