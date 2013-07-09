class HomeController < ApplicationController
  def index
  	@microcuentos = Microcuento.all
  end
end
