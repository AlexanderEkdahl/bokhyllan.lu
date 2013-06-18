class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.hstore :properties, default: {}

      t.timestamps
    end
  end
end
