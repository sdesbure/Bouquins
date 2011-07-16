require 'spec_helper'

describe "authors/edit.html.haml" do
  before(:each) do
    @author = assign(:author, stub_model(Author))
  end

  it "renders the edit author form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => authors_path(@author), :method => "post" do
    end
  end
end
