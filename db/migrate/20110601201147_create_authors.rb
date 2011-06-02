class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors do |t|
      t.string :name
      t.string :first_name
      t.string :nickname
      t.string :wikipedia_url
      t.string :image_url

      t.timestamps
    end
  end

  def self.down
    drop_table :authors
  end
end
