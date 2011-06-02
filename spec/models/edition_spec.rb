require 'spec_helper'

describe Edition do
  should_have_column :id, :type => :integer
  should_have_column :isbn, :type => :string
  should_have_column :image_url, :type => :string
  should_have_column :year, :type => :date

  should_belong_to :book
  should_belong_to :editor
end
