class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.references :item, index: true
      t.references :buyer, index: true
      t.integer :price
    end
  end
end
