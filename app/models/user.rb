class User < ActiveRecord::Base
  attr_accessible :bio, :lastname, :name, :username
end
