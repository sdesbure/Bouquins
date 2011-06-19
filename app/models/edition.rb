class Edition  < ActiveRecord::Base

  belongs_to :book
  belongs_to :editor

  has_and_belongs_to_many :users
  has_many :readings, :foreign_key => "read_edition_id"
  has_many :readers, :through => :readings, :class_name => "User"
end
