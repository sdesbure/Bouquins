require 'spec_helper'

describe Editor do
  it "should have some properties" do
    Editor.should have_property(:id)
    Editor.should have_property(:name)
    Editor.should have_property(:website)
    Editor.should have_property(:logo)
    Editor.should have_property(:wikipedia_url)
    Editor.should have_property(:created_at)
    Editor.should have_property(:updated_at)
  end

  it "should have relationships" do
    Editor.should have_many(:editions)
  end
end
