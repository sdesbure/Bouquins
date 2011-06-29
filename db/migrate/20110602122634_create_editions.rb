class CreateEditions < ActiveRecord::Migration
  def self.up
    create_table :editions do |t|
      t.string :isbn10
      t.string :isbn13
      t.string :image_url
      t.date :year
      t.references :book
      t.references :editor

      t.timestamps
    end
  end

  def self.down
    drop_table :editions
  end
end
