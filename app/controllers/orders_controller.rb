class OrdersController < ApplicationController
  before_action :authenticate, :must_be_verified, except: :show
  before_action :set_order, only: [:show, :buy, :destroy, :cancel]

  def create
    @item          = Item.find(params[:item_id])
    @order         = @item.orders.build(order_params)
    @order.user_id = current_user.id

    if @order.save
      redirect_to(@item, success: t(:order_created))
    else
      render 'items/show'
    end
  end

  def show
  end

  def buy
    render 'invalid' unless @order.buy(current_user)
  end

  def destroy
    @order.destroy

    redirect_to(user_path, success: t(:order_destroyed))
  end

  def cancel
    @order.cancel_purchase

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
