require 'spec_helper'

describe Author do
  should_have_column :name, :type => :string
  should_have_column :first_name, :type => :string
  should_have_column :nickname, :type => :string
  should_have_column :wikipedia_url, :type => :string
  should_have_column :image_url, :type => :string

  should_have_and_belong_to_many :books
end
