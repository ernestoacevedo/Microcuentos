class AuthenticationsController < ApplicationController
  
  def new
  end

  def create
    auth = request.env["omniauth.auth"]
    if auth.provider=="facebook"
      data = auth.extra.raw_info 
    end 
    # Verifica si la autentificación había sido creada anteriormente.
    authentication = Authentication.find_by_provider_and_uid(auth.provider,auth.uid)
     
    if authentication
      # Autentificación encontrada, el usuario inicia sesión.
      flash[:notice] = "Bienvenido."
      sign_in_and_redirect :user, User.find(authentication.user_id)
    else
      # No se encuentra autentificación.
      @user = User.where(:email => data.email).first
      if @user.nil?
        # No existe el usuario, procede a crearlo.
        generated_password = Devise.friendly_token.first(8)
        @user = User.new :email => data.email, :name => data.first_name, :lastname => data.last_name, :password => generated_password
        if @user.save(:validate => false)
          flash[:notice] = "Cuenta creada satisfactoriamente."
          @authentication = Authentication.new :uid => auth.uid, :provider => auth.provider
          @user.authentications << @authentication
          sign_in(:user, @user)
          redirect_to root_path
        else
          flash[:error] = "Error creando la cuenta."
          redirect_to root_url
        end
      else
        # El usuario existe, se debe asociar a la autentificación
        authentication = Authentication.new :uid => auth.uid, :provider => auth.provider
        if current_user.nil?
          #El usuario no está logueado
          @user.authentications << authentication
          @user.save
          sign_in_and_redirect :user, @user
        else
          if current_user.id==@user.id
            #El usuario logueado corresponde con el usuario de la autentificación
            current_user.authentications << authentication
            current_user.save
          else
            @user.authentications << authentication
            @user.save
            sign_in_and_redirect :user, @user
          end
        end
      end
    end
  end

  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy

    respond_to do |format|
      format.html { redirect_to authentications_url }
      format.json { head :no_content }
    end
  end
end
