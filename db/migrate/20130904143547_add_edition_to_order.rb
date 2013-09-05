class AddEditionToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :edition, :string
  end
end
