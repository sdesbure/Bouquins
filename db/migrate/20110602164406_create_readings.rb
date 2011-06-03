class CreateReadings < ActiveRecord::Migration
  def self.up
    create_table :readings do |t|
      t.references :read_book
      t.references :reader
      t.datetime :start_read
      t.datetime :end_read

      t.timestamps
    end
  end

  def self.down
    drop_table :readings
  end
end
