class CreateOwnings < ActiveRecord::Migration
  def self.up
    create_table :ownings do |t|
      t.references :owned_edition
      t.references :owner

      t.timestamps
    end
  end

  def self.down
    drop_table :ownings
  end
end
