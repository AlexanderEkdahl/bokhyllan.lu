class ItemsController < ApplicationController
  def index
    if params[:search]
      items = Item.search(params[:search])

      case items.length
      when 0
        render 'not_found'
      when 1
        redirect_to(items.first)
      else
        render 'search_results'
      end
    end
  end

  def show
    @item  = Item.find(params[:id])
    @order = @item.orders.build
    fresh_when(@item)
  end

  def search
    item = Item.search(params[:search])

    if item
      redirect_to(item)
    else
      render('not_found')
    end
  end

  def typeahead
    @items = Item.all
    fresh_when(last_modified: Item.last_modified, public: true)
    expires_in(3.hours, public: true)
  end
end
