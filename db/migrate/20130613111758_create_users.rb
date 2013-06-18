class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :password_digest
      t.boolean :verified, default: false
      t.hstore :properties, default: {}

      t.timestamps
    end

    add_index :users, :login, unique: true
  end
end
