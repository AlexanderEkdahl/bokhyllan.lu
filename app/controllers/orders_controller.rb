class OrdersController < ApplicationController
  before_action :authenticate, :must_be_verified
  before_action :set_order, only: [:buy, :destroy, :cancel]

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
    render 'invalid' unless @order.update_attributes(buyer_id: current_user.id)
  end

  def destroy
    @order.destroy

    redirect_to(user_path, success: t(:order_destroyed))
  end

  def cancel
    @order.update_attributes(buyer_id: nil)

    redirect_to(user_path, success: t(:order_canceled))
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:price, :quality)
    end
end
