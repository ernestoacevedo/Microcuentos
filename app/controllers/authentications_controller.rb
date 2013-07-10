class AuthenticationsController < ApplicationController


  def new
  end

  def create
    def create
      auth = request.env["omniauth.auth"]
     
      # Try to find authentication first
      authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
     
      if authentication
        # Authentication found, sign the user in.
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, authentication.user)
      else
        # Authentication not found, thus a new user.
        user = User.new
        user.email = auth['extra']['email']
        user.name = auth['extra']['name']
        generated_password = Devise.friendly_token.first(8)
        user.password = generated_password
        if user.save(:validate => false)
          #flash[:notice] = "Account created and signed in successfully."
          sign_in(:user, user)
          redirect_to root_path
        else
          flash[:error] = "Error while creating a user account. Please try again."
          redirect_to root_url
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
