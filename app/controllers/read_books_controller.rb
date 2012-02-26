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

  def destroy
    @user = User.find(params[:user_id])

    unless @user.nil?
      @edition = Edition.find(params[:id])
      unless @edition.nil?
        Reading.find_all_by_reader_id_and_read_edition_id(@user.id, @edition.id).each do |reading|
          unless reading.destroy
            respond_to do |format|
              format.html { redirect_to(user_read_books_path(@user), :flash => {:error => "Problème avec l'action, veuillez réésayer plus tard"}) }
              format.xml  { render :xml => reading.errors, :status => :unprocessable_entity }
            end
            return
          end
        end
        @read_editions = @user.read_editions.order("created_at DESC")

        respond_to do |format|
          format.html { redirect_to(user_read_books_path(@user), :flash => { :success => "Le livre #{@edition.book.title} a été enlevé de la liste des livres lus" }) }
          format.xml  { render :xml => @read_editions}
        end
      else
        respond_to do |format|
          format.html { redirect_to(user_read_books_path(@user), :flash => {:error => "Edition Inconnue"}) }
          format.xml  { render :xml => "Livre Inconnu", :status => :unprocessable_entity }
        end
      end
    else
      redirect_to root_url
    end
  end
end
