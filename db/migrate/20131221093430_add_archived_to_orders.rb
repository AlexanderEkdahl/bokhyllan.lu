class AddArchivedToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :archived, :boolean, default: false
  end
end
