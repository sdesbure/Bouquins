class OwnedBooksController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    unless @user.nil?
      @owned_editions = @user.owned_editions.order("created_at DESC")

      respond_to do |format|
        format.html # index.html.haml
        format.xml  { render :xml => @owned_editions}
      end
    else
      redirect_to root_url
    end
   end

  def destroy
  end

end
