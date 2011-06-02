require 'spec_helper'

describe Editor do
  should_have_column :id, :type => :integer
  should_have_column :name, :type => :string
  should_have_column :website, :type => :string
  should_have_column :logo, :type => :string
  should_have_column :wikipedia_url, :type => :string

  should_have_many :editions
  should_have_many :books, :through => :editions
end
