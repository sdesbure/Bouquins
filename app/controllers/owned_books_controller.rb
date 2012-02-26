#encoding: utf-8
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
    @user = User.find(params[:user_id])

    unless @user.nil?
      @edition = Edition.find(params[:id])
      unless @edition.nil?
        Owning.find_all_by_owner_id_and_owned_edition_id(@user.id, @edition.id).each do |owning|
          unless owning.destroy
            respond_to do |format|
              format.html { redirect_to(user_owned_books_path(@user), :flash => {:error => "Problème avec l'action, veuillez réésayer plus tard"}) }
              format.xml  { render :xml => owning.errors, :status => :unprocessable_entity }
            end
            return
          end
        end
        @owned_editions = @user.owned_editions.order("created_at DESC")

        respond_to do |format|
          format.html { redirect_to(user_owned_books_path(@user), :flash => { :success => "Le livre #{@edition.book.title} a été enlevé de la liste des livres possédés" }) }
          format.xml  { render :xml => @owned_editions}
        end
      else
        respond_to do |format|
          format.html { redirect_to(user_owned_books_path(@user), :flash => {:error => "Edition Inconnue"}) }
          format.xml  { render :xml => "Livre Inconnu", :status => :unprocessable_entity }
        end
      end
    else
      redirect_to root_url
    end
  end

end
