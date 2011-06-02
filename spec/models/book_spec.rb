require 'spec_helper'

describe Book do
  should_have_column :id, :type => :integer
  should_have_column :name, :type => :string
  should_have_column :description, :type => :text
  should_have_column :wikipedia_url, :type => :string

  should_have_and_belong_to_many :authors
  should_have_many :editions
  should_have_many :editors, :through => :editions

end
