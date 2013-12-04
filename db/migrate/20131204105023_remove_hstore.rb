class RemoveHstore < ActiveRecord::Migration
  def self.up
    execute "DROP EXTENSION hstore"
  end

  def self.down
    execute "CREATE EXTENSION hstore"
  end
end
