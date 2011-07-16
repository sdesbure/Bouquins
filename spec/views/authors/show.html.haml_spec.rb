require 'spec_helper'

describe "authors/show.html.haml" do
  before(:each) do
    @author = assign(:author, stub_model(Author))
  end

  it "renders attributes in <p>" do
    render
  end
end
