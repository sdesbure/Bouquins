class AddAmazonUrlToEdition < ActiveRecord::Migration
  def self.up
    add_column :editions, :amazon_url, :string
  end

  def self.down
    remove_column :editions, :amazon_url
  end
end
