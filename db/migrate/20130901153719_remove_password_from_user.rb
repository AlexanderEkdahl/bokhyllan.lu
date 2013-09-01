class RemovePasswordFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :password_digest
    remove_column :users, :verified
  end
end
