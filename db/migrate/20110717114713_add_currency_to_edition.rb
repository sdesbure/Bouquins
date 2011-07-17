class AddCurrencyToEdition < ActiveRecord::Migration
  def self.up
    add_column :editions, :currency, :string
  end

  def self.down
    remove_column :editions, :currency
  end
end
