require 'spec_helper'

describe User do
  should_have_and_belong_to_many :editions
  should_have_many :readings, :foreign_key => "reader_id"
  should_have_many :read_editions, :through => :readings, :class_name => "Edition"
end
