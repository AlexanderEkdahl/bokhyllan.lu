class ItemsController < ApplicationController
  def index
    fresh_when([signed_in?, flash], :public => true)
  end

  def show
    @item  = Item.includes(:orders).find(params[:id])
    @order = Order.new
    fresh_when([@item, signed_in?, flash], :public => true)
  end

  def typeahead
    @items = Item.all
    expires_in 3.hours, :public => true
  end
end
