class AddAlternativeToItem < ActiveRecord::Migration
  def change
    add_column :items, :alternative, :string
  end
end
