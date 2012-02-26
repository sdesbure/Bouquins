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

  describe "DELETE 'destroy'" do
    describe "with valid id" do
      before :each do
        @user = mock_model User
        @edition = mock_model Edition
        @reading = mock_model Reading
        @editions = []
        User.should_receive(:find).with("23").and_return(@user)
        Edition.should_receive(:find).with("25").and_return(@edition)
        Reading.should_receive(:find_all_by_reader_id_and_read_edition_id).with(@user.id,@edition.id).and_return([@reading,@reading])
        @reading.should_receive(:destroy).twice.and_return(true)
        @user.stub_chain(:read_editions, :order => "created_at DESC").and_return(@editions)
        @edition.stub_chain(:book,:title).and_return("blah")
        delete :destroy, :user_id => "23", :id => "25"
      end

      it { assigns(:user).should == @user }
      it { assigns(:edition).should == @edition }
      it { assigns(:read_editions).should == @editions }
      it { flash[:success].should_not be_nil}
      it { should redirect_to user_read_books_url(@user) }
    end

    describe "with invalid user_id" do
      it "redirect to root" do
        User.should_receive(:find).with("24").and_return(nil)
        delete :destroy, :user_id => "24", :id => "25"
        response.should redirect_to root_url
      end
    end

    describe "with invalid id" do
      before :each do
        @user = mock_model User
        User.should_receive(:find).with("23").and_return(@user)
        Edition.should_receive(:find).with("25").and_return(nil)
        delete :destroy, :user_id => "23", :id => "25"
      end 

      it { should redirect_to user_read_books_url(@user) }
      it { flash[:error].should_not be_nil}
    end

    describe "with issues on destroy" do
      before :each do
        @user = mock_model User
        @reading = mock_model Reading
        @edition = mock_model Edition
        User.should_receive(:find).with("23").and_return(@user)
        Edition.should_receive(:find).with("25").and_return(@edition)
        Reading.should_receive(:find_all_by_reader_id_and_read_edition_id).with(@user.id,@edition.id).and_return([@reading,@reading])
        @reading.should_receive(:destroy).once.and_return(false)
        delete :destroy, :user_id => "23", :id => "25"
      end

      it { should redirect_to user_read_books_url(@user) }
      it { flash[:error].should_not be_nil}
    end
  end
end
