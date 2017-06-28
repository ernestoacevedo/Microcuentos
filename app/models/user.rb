class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  :bio, :lastname, :name, :username, :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>", :mini => "50x50" }, :default_url => "/images/:style/missing.png"
  has_many :microcuentos, dependent: :destroy
  has_many :authentications
  has_many :comentarios, dependent: :destroy
end
