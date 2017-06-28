class Microcuento < ActiveRecord::Base
  attr_accessible :content, :likes, :title, :user_id
  
  attr_accessible :portada
  has_attached_file :portada, :styles => { :medium => "150x200>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  belongs_to :user
  has_many :comentarios
end