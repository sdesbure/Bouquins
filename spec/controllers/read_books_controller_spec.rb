require 'spec_helper'

describe ReadBooksController do

  describe "GET 'index'" do
    describe "with valid id" do
      before :each do
        @user = mock_model User
        @editions = []
        10.times { @editions << mock_model(Edition)}
        User.should_receive(:find).with("23").and_return(@user)
        @user.stub_chain(:read_editions, :order => "created_at DESC").and_return(@editions)
      end

      it "assign user at @user" do
        get :index, :user_id => "23"
        assigns(:user).should == @user
      end

      it "assigns editions to @read_editions" do
        get :index, :user_id => "23"
        assigns(:read_editions).should == @editions
      end
    end

    describe "with invalid id" do
      it "redirect to root" do
        User.should_receive(:find).with("24").and_return(nil)
        get :index, :user_id => "24"
        response.should redirect_to root_url
      end
    end
  end

end
