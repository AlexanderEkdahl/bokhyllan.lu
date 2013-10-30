class RemoveAlternativeFromItem < ActiveRecord::Migration
  def change
    remove_column :items, :alternative
  end
end
