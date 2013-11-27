class AddAuthorsToItems < ActiveRecord::Migration
  def change
    add_column :items, :authors, :string, array: true, default: []
  end
end
