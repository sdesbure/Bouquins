class Edition  < ActiveRecord::Base

  belongs_to :book, :counter_cache => true
  belongs_to :editor

  has_many :readings, :foreign_key => "read_edition_id"
  has_many :readers, :through => :readings, :class_name => "User"
  has_many :ownings, :foreign_key => "owned_edition_id"
  has_many :owners, :through => :ownings, :class_name => "User"
end
