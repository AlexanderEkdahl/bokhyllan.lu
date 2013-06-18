class OrdersController < ApplicationController
  before_action :authenticate
  before_action :set_order, only: [:destroy, :buy]

  def create
    item           = Item.find(params[:item_id])
    @order         = item.orders.build(order_params)
    @order.user_id = current_user.id

    if @order.save
      redirect_to item, flash: { success: 'Order was successfully created.' }
    else
      # TODO render item show
      render action: 'new'
    end
  end

  def destroy
    @order.destroy
    redirect_to @order.item
  end

  def buy
    render 'invalid' unless @order.update_attributes(buyer_id: current_user.id)
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:price)
    end
end
