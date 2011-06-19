class AddOwningsCountToEdition < ActiveRecord::Migration
  def self.up
     add_column :editions, :ownings_count, :integer
  end

  def self.down
    remove_column :editions, :ownings_count
  end
end
