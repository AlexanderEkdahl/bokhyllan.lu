class AddIsbnToItems < ActiveRecord::Migration
  def change
    add_column :items, :isbn, :string
    add_index :items,  :isbn, unique: true
  end
end
