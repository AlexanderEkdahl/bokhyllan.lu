class RemoveBuyerFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :buyer_id
  end
end
