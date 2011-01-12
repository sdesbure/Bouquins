require 'spec_helper'

describe Author do
  it "should have some properties" do
    Author.should have_property(:id)
    Author.should have_property(:name)
    Author.should have_property(:first_name)
    Author.should have_property(:nickname)
    Author.should have_property(:wikipedia_url)
    Author.should have_property(:image_url)
    Author.should have_property(:created_at)
    Author.should have_property(:updated_at)
  end
end
