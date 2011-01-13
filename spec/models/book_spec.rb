require 'spec_helper'

describe Book do
  it "should have properties" do
    Book.should have_property(:id)
    Book.should have_property(:created_at)
    Book.should have_property(:updated_at)
  end

  it "should have relationships" do
    Book.should have_many(:authors)
    Book.should have_many(:editions)
  end
end
