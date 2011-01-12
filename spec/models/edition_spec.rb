require 'spec_helper'

describe Edition do
  it "should have some properties" do
    Edition.should have_property(:id)
    Edition.should have_property(:isbn)
    Edition.should have_property(:image_url)
    Edition.should have_property(:year)
    Edition.should have_property(:created_at)
    Edition.should have_property(:updated_at)
  end
end
