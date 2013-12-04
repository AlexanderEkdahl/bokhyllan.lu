class RemovePropertiesFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :properties
  end
end
