class CreateBookUserJoinTable < ActiveRecord::Migration
  def self.up
    create_table :books_users, :id => false do |t|
      t.references :user
      t.references :book
    end
  end

  def self.down
    drop_table :books_users
  end
end
