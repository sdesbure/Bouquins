class CreateEditionUserJoinTable < ActiveRecord::Migration
  def self.up
    create_table :editions_users, :id => false do |t|
      t.references :user
      t.references :edition
    end
  end

  def self.down
    drop_table :books_users
  end
end
