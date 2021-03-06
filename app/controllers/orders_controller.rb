class OrdersController < ApplicationController
  before_action :authenticate, except: :show

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
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    # should notify user that it has been removed
    redirect_to root_path(search: Item.from_param(params[:item_id]))
  end

  def destroy
    @order = Order.find(params[:id])

    unauthenticate unless @order.user == current_user

    @order.archive
    redirect_to(user_path, success: t(:order_destroyed))
  end

  private

  def order_params
    params.require(:order).permit(:price, :quality, :edition)
  end
end
