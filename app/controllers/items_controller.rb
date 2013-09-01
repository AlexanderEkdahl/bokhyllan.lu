class ItemsController < ApplicationController
  before_action :authenticate, only: [:new, :create]

  include Metatags
  include Moderator

  def index
    unless params[:search].blank?
      @items = Item.search(params[:search])

      case @items.length
      when 0
        render 'not_found'
      when 1
        redirect_to(@items.first)
      else
        render 'search_results'
      end
    end
  rescue Errno::ECONNREFUSED
    render 'not_found'
  end

  def new
    @item = Item.new(params[:name] ? { name: params[:name] } : nil)
    @order = @item.orders.build
  end

  def create
    @item = Item.new(item_params)
    @item.orders.first.user_id = current_user.id if @item.orders.first

    if @item.save
      moderator("Created #{@item.name}")
      redirect_to(@item)
    else
      render 'new'
    end
  end

  def show
    @item  = Item.find(params[:id])
    @order = @item.orders.build
  end

  def autocomplete
    @items = Item.search(params[:search])
  end

  private

    def item_params
      params.require(:item).permit(:name, *Item::PROPERTIES_KEYS, orders_attributes: [:price, :quality])
    end
end
