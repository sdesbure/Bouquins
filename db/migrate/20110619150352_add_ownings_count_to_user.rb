class AddOwningsCountToUser < ActiveRecord::Migration
  def self.up
     add_column :users, :ownings_count, :integer
  end

  def self.down
    remove_column :users, :ownings_count
  end
end
