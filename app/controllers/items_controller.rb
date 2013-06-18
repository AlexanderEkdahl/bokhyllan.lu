class ItemsController < ApplicationController
  def index
  end

  def show
    @item  = Item.includes(:orders).find(params[:id])
    @order = Order.new
  end

  def typeahead
    @items = Item.all
  end
end
