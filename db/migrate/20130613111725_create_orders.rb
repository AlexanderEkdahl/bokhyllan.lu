class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.references :item, index: true
      t.references :buyer, index: true
      t.integer :price
      t.integer :quality, limit: 2

      t.timestamps
    end
  end
end
