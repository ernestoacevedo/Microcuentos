class MicrocuentosController < ApplicationController
  # GET /microcuentos
  # GET /microcuentos.json
  def index
    @microcuentos = Microcuento.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @microcuentos }
    end
  end

  # GET /microcuentos/1
  # GET /microcuentos/1.json
  def show
    @microcuento = Microcuento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @microcuento }
    end
  end

  # GET /microcuentos/new
  # GET /microcuentos/new.json
  def new
    @microcuento = Microcuento.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @microcuento }
    end
  end

  # GET /microcuentos/1/edit
  def edit
    @microcuento = Microcuento.find(params[:id])
  end

  # POST /microcuentos
  # POST /microcuentos.json
  def create
    @microcuento = Microcuento.new(params[:microcuento])

    respond_to do |format|
      if @microcuento.save
        format.html { redirect_to @microcuento, notice: 'Microcuento was successfully created.' }
        format.json { render json: @microcuento, status: :created, location: @microcuento }
      else
        format.html { render action: "new" }
        format.json { render json: @microcuento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /microcuentos/1
  # PUT /microcuentos/1.json
  def update
    @microcuento = Microcuento.find(params[:id])

    respond_to do |format|
      if @microcuento.update_attributes(params[:microcuento])
        format.html { redirect_to @microcuento, notice: 'Microcuento was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @microcuento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microcuentos/1
  # DELETE /microcuentos/1.json
  def destroy
    @microcuento = Microcuento.find(params[:id])
    @microcuento.destroy

    respond_to do |format|
      format.html { redirect_to microcuentos_url }
      format.json { head :no_content }
    end
  end
end
