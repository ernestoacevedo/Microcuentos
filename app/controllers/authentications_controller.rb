class AuthenticationsController < ApplicationController


  def new
    auth         = request.env['omniauth.auth']
    @provider     = auth['provider']
    @uid          = auth['uid']
    bio          = ''
    if @provider == 'twitter'
      name       = auth['info']['name'].split(' ',2).first
      lastname  = auth['info']['name'].split(' ',2).last
      email      = ""
      bio        = auth['info']['description']
      
    elsif @provider == 'facebook'
      name       = auth['extra']['raw_info']['first_name']
      email      = auth['info']['email']
      lastname  = auth['info']['last_name']
    else
      flash[:error]=t 'mensajes.ingreso.provider_fail'
    end

    if @provider && @uid 
      @authentication = Authentication.where(:uid => @uid, :provider => @provider).first
      if @authentication.nil?
        #Buscar un usuario por el email
        @user = User.where(:email => email).first
        if @user.nil?
          #Crear un nuevo usuario
          
          @user.email = email
          @user.name = name
          @user.lastname = lastname
          password = Devise.friendly_token.first(8)
          @user.password = password
          @user.confirm_password = password
          @user.save
        else
          #Asociar al usuario ya existente el provider
          auth = Authentication.new(:provider => @provider, :uid => @uid)
          #Chequear si el usuario ya esta logueado
          if !current_user.nil?
            if current_user.id == @user.id 
              current_user.authentications << auth
              current_user.save 
            else
             #Loguear al usuario
             @user.authentications << auth 
             @user.save
             sign_in_and_redirect :user, @user 
            end
          else
            @user.authentications << auth 
            @user.save
            sign_in_and_redirect :user, @user
          end
        end
        
      else
        #La autenticacion ya existe, loguear al usuario
        @user = User.find(@authentication.user_id)
        sign_in_and_redirect :user, @user 
      end
    else
      flash[:error] = t "mensajes.ingreso.no_provider"
      redirect_to root_path
    end
  end

  def create
    usuario = User.where(:email => params[:user][:email]).first
    
    if !usuario.nil?
      usuario.authentications << Authentication.new(:provider => params[:user][:provider], :uid => params[:user][:uid])
      usuario.save
      sign_in_and_redirect(:user,usuario)
    else
      @user = User.new params[:user]
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
