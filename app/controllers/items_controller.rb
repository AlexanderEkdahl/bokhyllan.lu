class ItemsController < ApplicationController
  before_action :authenticate, only: [:new, :create]

  include Moderator

  def index
    unless params[:search].blank?
      @items = Item.search(params[:search], autocomplete: true, suggest: true, limit: 10)
      track("Searched", query: params[:search], results: @items.length)

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
    @item  = Item.new(name: params[:name] || nil)
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
    @items = Item.search(params[:search], autocomplete: true, limit: 5).map do |item|
      {
        value: item.name,
        url: item_path(item)
      }
    end

    render json: @items
  end

  private

  def item_params
    params.require(:item).permit(:name, *Item::PROPERTIES, orders_attributes: [:price, :quality, :edition])
  end
end
