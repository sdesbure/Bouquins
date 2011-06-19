require 'spec_helper'

describe User do
  should_have_many :owned_editions, :through => :ownings
  should_have_many :ownings, :foreign_key => "owner_id"
  should_have_many :readings, :foreign_key => "reader_id"
  should_have_many :read_editions, :through => :readings, :class_name => "Edition"
  should_have_column :readings_count, :type => :integer
end
