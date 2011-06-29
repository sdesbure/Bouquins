#encoding: utf-8
class ReadBooksController < ApplicationController
  # GET /users/1/read_books
  # GET /users/1/read_boooks.xml
  def index
    @user = User.find(params[:user_id])

    unless @user.nil?
      @read_editions = @user.read_editions.order("created_at DESC")

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @read_editions}
      end
    else
      redirect_to root_url
    end
  end

end
