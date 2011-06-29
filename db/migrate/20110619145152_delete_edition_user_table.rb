class DeleteEditionUserTable < ActiveRecord::Migration
  def self.up
    drop_table :editions_users
  end

  def self.down
    create_table :editions_users, :id => false do |t|
      t.references :user
      t.references :edition
    end
  end
end
