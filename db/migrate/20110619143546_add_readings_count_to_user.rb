class AddReadingsCountToUser < ActiveRecord::Migration
  def self.up
     add_column :users, :readings_count, :integer
  end

  def self.down
    remove_column :users, :readings_count
  end
end
