class ItemsController < ApplicationController
  before_action :authenticate, only: [:new, :create]

  include Metatags

  def index
    if params[:search]
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
  end

  def new
    @item = Item.new(params[:name] ? { name: params[:name] } : nil)
    @order = @item.orders.build
  end

  def create
    @item = Item.new(item_params)
    @item.orders.first.user_id = current_user.id

    if @item.save
      redirect_to(@item)
    else
      render 'new'
    end
  end

  def show
    @item  = Item.find(params[:id])
    @order = @item.orders.build
    fresh_when(@item)
  end

  def typeahead
    @items = Item.all
    fresh_when(last_modified: Item.last_modified, public: true)
    expires_in(3.hours, public: true)
  end

  private

    def item_params
      params.require(:item).permit(:name, orders_attributes: [:price, :quality])
    end
end
