require 'spec_helper'

describe "authors/index.html.haml" do
  before(:each) do
    assign(:authors, [
      stub_model(Author),
      stub_model(Author)
    ])
  end

  it "renders a list of authors" do
    render
  end
end
