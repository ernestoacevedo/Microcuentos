class Comentario < ActiveRecord::Base
  attr_accessible :contenido, :microcuento_id
  belongs_to :microcuento
end
