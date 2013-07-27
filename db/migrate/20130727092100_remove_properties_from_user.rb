class RemovePropertiesFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :properties
    add_column :users, :name, :string
    add_column :users, :phone, :string
  end
end
