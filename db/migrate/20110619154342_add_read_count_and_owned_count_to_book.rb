class AddReadCountAndOwnedCountToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :read_count, :integer, :default => 0
    add_column :books, :owned_count, :integer, :default => 0
  end

  def self.down
    remove_column :books, :read_count
    remove_column :books, :owned_count
  end
end
