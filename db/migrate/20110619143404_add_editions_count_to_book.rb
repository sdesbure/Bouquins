class AddEditionsCountToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :editions_count, :integer
  end

  def self.down
    remove_column :books, :editions_count
  end
end
