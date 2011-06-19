require 'spec_helper'

describe Edition do
  should_have_column :id, :type => :integer
  should_have_column :isbn10, :type => :string
  should_have_column :image_url, :type => :string
  should_have_column :year, :type => :date
  should_have_column :readings_count, :type => :integer
  should_have_column :ownings_count, :type => :integer

  should_belong_to :book, :counter_cache => true
  should_belong_to :editor
  should_have_many :readers, :through => :readings, :class_name => "User"
  should_have_many :readings, :foreign_key => "read_edition_id"
  should_have_many :ownings, :foreign_key => "owned_edition_id"
  should_have_many :owners, :through => :ownings, :class_name => "User"
end
