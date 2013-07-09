class Microcuento < ActiveRecord::Base
  attr_accessible :content, :likes, :title, :user_id
  belongs_to :user
end
