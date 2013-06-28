class OrdersController < ApplicationController
  before_action :authenticate, :must_be_verified

  def create
    item           = Item.find(params[:item_id])
    @order         = item.orders.build(order_params)
    @order.user_id = current_user.id

    if @order.save
      redirect_to item, success: 'Order was successfully created.'
    else
      # TODO render item show
      render action: 'new'
    end
  end

  def buy
    @order = Order.find(params[:id])
    render 'invalid' unless @order.update_attributes(buyer_id: current_user.id)
  end

  private
    def order_params
      params.require(:order).permit(:price, :quality)
    end
end
