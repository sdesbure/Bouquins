require "spec_helper"

describe ReadBooksController do
  describe "routing" do

    it "routes to #index" do
      get("/users/1/read_books").should route_to("read_books#index", :user_id => "1")
    end

    it "routes to #destroy" do
      delete("/users/1/read_books/2").should route_to("read_books#destroy", :user_id => "1", :id => "2")
    end
  end
end
