class ItemsController < ApplicationController
  before_action :authenticate, only: [:new, :create]

  include Metatags

  def index
    if params[:search]
      @items = Item.search(params[:search])
      track("Searched for an item", query: params[:search], results: @items.length)

      case @items.length
      when 0
        render 'not_found'
      when 1
        redirect_to(@items.first)
      else
        render 'search_results'
      end
    end
  end

  def new
    @item = Item.new(params[:name] ? { name: params[:name] } : nil)
    @order = @item.orders.build
  end

  def create
    @item = Item.new(item_params)
    @item.orders.first.user_id = current_user.id

    if @item.save
      track("Created a new item", id: @item.id)
      redirect_to(@item)
    else
      render 'new'
    end
  end

  def show
    @item  = Item.find(params[:id])
    @order = @item.orders.build
    # fresh_when(@item)
  end

  def typeahead
    @items = Item.all
    fresh_when(last_modified: Item.last_modified, public: true)
    expires_in(3.hours, public: true)
  end

  private

    def item_params
      params.require(:item).permit(:name, *Item::PROPERTIES_KEYS, orders_attributes: [:price, :quality])
    end
end
