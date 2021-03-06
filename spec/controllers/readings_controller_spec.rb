require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ReadingsController do

  # This should return the minimal set of attributes required to create a valid
  # Reading. As you add validations to Reading, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # describe "GET index" do
  #   it "assigns all readings as @readings" do
  #     reading = Reading.create! valid_attributes
  #     get :index
  #     assigns(:readings).should eq([reading])
  #   end
  # end

  # describe "GET show" do
  #   it "assigns the requested reading as @reading" do
  #     reading = Reading.create! valid_attributes
  #     get :show, :id => reading.id.to_s
  #     assigns(:reading).should eq(reading)
  #   end
  # end

  # describe "GET new" do
  #   it "assigns a new reading as @reading" do
  #     get :new
  #     assigns(:reading).should be_a_new(Reading)
  #   end
  # end

  # describe "GET edit" do
  #   it "assigns the requested reading as @reading" do
  #     reading = Reading.create! valid_attributes
  #     get :edit, :id => reading.id.to_s
  #     assigns(:reading).should eq(reading)
  #   end
  # end

  describe "POST create" do
    describe "with valid user_id and book_id" do
      before :each do
        @user = mock_model User
        @edition = mock_model Edition
        @reading = mock_model Reading
        User.should_receive(:find).with("24").and_return(@user)
        Edition.should_receive(:find).with("33").and_return(@edition)
        Reading.should_receive(:new).and_return(@reading)
        @reading.should_receive(:save).and_return(true)
        @edition.stub_chain(:book, :title).and_return("blah")
        post :create, :reading => { :reader_id => "24", :read_edition_id => "33" }
      end

      it { response.should redirect_to user_url(@user)  }

      it { flash[:success].should_not be_nil }
    end

    describe "with invalid user_id" do
      before :each do
        edition = mock_model Edition
        User.should_receive(:find).with("24").and_return(nil)
        Edition.should_receive(:find).with("33").and_return(edition)
        post :create, :reading => { :reader_id => "24", :read_edition_id => "33" }
      end

      it { response.should redirect_to root_url }
      it { flash[:error].should_not be_nil }
    end

    describe "with invalid edition_id" do
      before :each do 
        user = mock_model User
        User.should_receive(:find).with("24").and_return(user)
        Edition.should_receive(:find).with("33").and_return(nil)
        post :create, :reading => { :reader_id => "24", :read_edition_id => "33" }
      end

      it { response.should redirect_to root_url }
      it { flash[:error].should_not be_nil }
    end
  end

# describe "PUT update" do
#   describe "with valid params" do
#     it "updates the requested reading" do
#       reading = Reading.create! valid_attributes
#       # Assuming there are no other readings in the database, this
#       # specifies that the Reading created on the previous line
#       # receives the :update_attributes message with whatever params are
#       # submitted in the request.
#       Reading.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
#       put :update, :id => reading.id, :reading => {'these' => 'params'}
#     end

#     it "assigns the requested reading as @reading" do
#       reading = Reading.create! valid_attributes
#       put :update, :id => reading.id, :reading => valid_attributes
#       assigns(:reading).should eq(reading)
#     end

#     it "redirects to the reading" do
#       reading = Reading.create! valid_attributes
#       put :update, :id => reading.id, :reading => valid_attributes
#       response.should redirect_to(reading)
#     end
#   end

#   describe "with invalid params" do
#     it "assigns the reading as @reading" do
#       reading = Reading.create! valid_attributes
#       # Trigger the behavior that occurs when invalid params are submitted
#       Reading.any_instance.stub(:save).and_return(false)
#       put :update, :id => reading.id.to_s, :reading => {}
#       assigns(:reading).should eq(reading)
#     end

#     it "re-renders the 'edit' template" do
#       reading = Reading.create! valid_attributes
#       # Trigger the behavior that occurs when invalid params are submitted
#       Reading.any_instance.stub(:save).and_return(false)
#       put :update, :id => reading.id.to_s, :reading => {}
#       response.should render_template("edit")
#     end
#   end
# end

# describe "DELETE destroy" do
#   it "destroys the requested reading" do
#     reading = Reading.create! valid_attributes
#     expect {
#       delete :destroy, :id => reading.id.to_s
#     }.to change(Reading, :count).by(-1)
#   end

#   it "redirects to the readings list" do
#     reading = Reading.create! valid_attributes
#     delete :destroy, :id => reading.id.to_s
#     response.should redirect_to(readings_url)
#   end
# end

end
