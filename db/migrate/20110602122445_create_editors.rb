class CreateEditors < ActiveRecord::Migration
  def self.up
    create_table :editors do |t|
      t.string :name
      t.string :website
      t.string :logo
      t.string :wikipedia_url

      t.timestamps
    end
  end

  def self.down
    drop_table :editors
  end
end
