#encoding: utf-8
class OwningsController < ApplicationController
  # GET /ownings
  # GET /ownings.xml
  def index
    @ownings = Owning.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ownings }
    end
  end

  # GET /ownings/1
  # GET /ownings/1.xml
  def show
    @owning = Owning.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @owning }
    end
  end

  # GET /ownings/new
  # GET /ownings/new.xml
  def new
    @owning = Owning.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @owning }
    end
  end

  # GET /ownings/1/edit
  def edit
    @owning = Owning.find(params[:id])
  end

  # POST /ownings
  # POST /ownings.xml
  def create
    id = nil
    params.each_key{|key| key.to_s.match("owned_edition_[0-9]*").nil? ? nil : id = key.to_s.split("_").last}
    unless id.nil?
      parameters = params[:owning][id]
    else
      parameters = params[:owning]
    end
    @owning = Owning.new(parameters)
    @user = User.find(parameters[:owner_id])
    @edition = Edition.find(parameters[:owned_edition_id])

    unless @user.nil? || @edition.nil?

      respond_to do |format|
        if @owning.save
          format.html { redirect_to(@user, :flash => { :success => "Le livre #{@edition.book.title} a été marqué comme possédé"}) }
          format.xml  { head :ok }
        else
          format.html { redirect_to(@user, :flash => { :error => "Problème avec l'action, veuillez réésayer plus tard"}) }
          format.xml  { render :xml => @owning.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to(root_url, :flash => { :error => "L'utilisateur ou le livre est invalide" }) 
    end
  end

  # PUT /ownings/1
  # PUT /ownings/1.xml
  def update
    @owning = Owning.find(params[:id])

    respond_to do |format|
      if @owning.update_attributes(params[:owning])
        format.html { redirect_to(@owning, :notice => 'Owning was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @owning.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ownings/1
  # DELETE /ownings/1.xml
  def destroy
    @owning = Owning.find(params[:id])
    @owning.destroy

    respond_to do |format|
      format.html { redirect_to(ownings_url) }
      format.xml  { head :ok }
    end
  end
end
