class ComentariosController < ApplicationController
  def create
    @microcuento = Microcuento.find(params[:microcuento_id])
    @comentario = @microcuento.comentarios.create(params[:comentario])

    respond_to do |format|
      if @comentario.save
        format.html { redirect_to @microcuento, notice: 'Comentario creado satisfactoriamente' }
        format.json { render json: @comentario, status: :created, location: @comentario }
      else
        format.html { render action: "new" }
        format.json { render json: @comentario.errors, status: :no_realizado}
      end
    end

end
end
