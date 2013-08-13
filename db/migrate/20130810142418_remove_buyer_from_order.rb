class RemoveBuyerFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :buyer_id, :integer
  end
end
