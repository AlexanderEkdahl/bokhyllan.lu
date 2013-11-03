class OrdersController < ApplicationController
  before_action :authenticate, except: :show

  def create
    @item          = Item.find(params[:item_id])
    @order         = @item.orders.build(order_params)
    @order.user_id = current_user.id

    if @order.save
      track("Created order", item: @order.item.name)
      redirect_to(@item, success: t(:order_created))
    else
      render 'items/show'
    end
  end

  def show
    @order = Order.find(params[:id])
    track("Browsed order", item: @order.item.name)
  end

  def destroy
    @order = Order.find(params[:id])

    if @order.user == current_user
      @order.destroy
      track("Destroyed order", item: @order.item.name)

      redirect_to(user_path, success: t(:order_destroyed))
    end
  end

  private

  def order_params
    params.require(:order).permit(:price, :quality, :edition)
  end
end
