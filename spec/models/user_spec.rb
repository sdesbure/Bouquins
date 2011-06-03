require 'spec_helper'

describe User do
  should_have_and_belong_to_many :books
  should_have_many :readings, :foreign_key => "reader_id"
  should_have_many :read_books, :through => :readings, :class_name => "Book"
end
