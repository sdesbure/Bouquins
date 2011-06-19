class AddReadingsCountToEdition < ActiveRecord::Migration
  def self.up
     add_column :editions, :readings_count, :integer
  end

  def self.down
    remove_column :editions, :readings_count
  end
end
