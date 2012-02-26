#encoding: utf-8
class ReadingsController < ApplicationController
  # GET /readings
  # GET /readings.xml
  def index
    @readings = Reading.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @readings }
    end
  end

  # GET /readings/1
  # GET /readings/1.xml
  def show
    @reading = Reading.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reading }
    end
  end

  # GET /readings/new
  # GET /readings/new.xml
  def new
    @reading = Reading.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reading }
    end
  end

  # GET /readings/1/edit
  def edit
    @reading = Reading.find(params[:id])
  end

  # POST /readings
  # POST /readings.xml
  def create
    id = nil
    params.each_key{|key| key.to_s.match("read_edition_[0-9]*").nil? ? nil : id = key.to_s.split("_").last}
    unless id.nil?
      parameters = params[:reading][id][:end_read].nil? ? params[:reading][id].merge({:end_read => Time.now}) :
                                                          params[:reading][id]

    else
    parameters = params[:reading][:end_read].nil? ? params[:reading].merge({:end_read => Time.now}) :
                                                    params[:reading]
    end
    @reading = Reading.new(parameters)
    @user = User.find(parameters[:reader_id])
    @edition = Edition.find(parameters[:read_edition_id])

    unless @user.nil? || @edition.nil?

    respond_to do |format|
      if @reading.save
        format.html { redirect_to(@user, :flash => { :success => "Le livre #{@edition.book.title} a été marqué comme lu"}) }
        format.xml  { head :ok }
      else
        format.html { redirect_to(@user, :flash => { :error => "Problème avec l'action, veuillez réésayer plus tard"}) }
        format.xml  { render :xml => @reading.errors, :status => :unprocessable_entity }
      end
    end
    else
      redirect_to(root_url, :flash => { :error => "L'utilisateur ou le livre est invalide" }) 
    end
  end

  # PUT /readings/1
  # PUT /readings/1.xml
  def update
    @reading = Reading.find(params[:id])

    respond_to do |format|
      if @reading.update_attributes(params[:reading])
        format.html { redirect_to(@reading, :notice => 'Reading was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reading.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /readings/1
  # DELETE /readings/1.xml
  def destroy
    @reading = Reading.find(params[:id])
    @reading.destroy

    respond_to do |format|
      format.html { redirect_to(readings_url) }
      format.xml  { head :ok }
    end
  end
end
