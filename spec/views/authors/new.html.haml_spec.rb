require 'spec_helper'

describe "authors/new.html.haml" do
  before(:each) do
    assign(:author, stub_model(Author).as_new_record)
  end

  it "renders new author form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => authors_path, :method => "post" do
    end
  end
end
