require "spec_helper"

describe OwningsController do
  describe "routing" do

 #   it "routes to #index" do
 #     get("/ownings").should route_to("ownings#index")
 #   end

 #   it "routes to #new" do
 #     get("/ownings/new").should route_to("ownings#new")
 #   end

 #   it "routes to #show" do
 #     get("/ownings/1").should route_to("ownings#show", :id => "1")
 #   end

 #   it "routes to #edit" do
 #     get("/ownings/1/edit").should route_to("ownings#edit", :id => "1")
 #   end

    it "routes to #create" do
      post("/ownings").should route_to("ownings#create")
    end

 #   it "routes to #update" do
 #     put("/ownings/1").should route_to("ownings#update", :id => "1")
 #   end

 #   it "routes to #destroy" do
 #     delete("/ownings/1").should route_to("ownings#destroy", :id => "1")
 #   end

  end
end
