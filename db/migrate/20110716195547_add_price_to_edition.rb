class AddPriceToEdition < ActiveRecord::Migration
  def self.up
    add_column :editions, :price, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :editions, :price
  end
end
