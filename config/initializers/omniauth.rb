Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, 'LlfwLvSwDeUkbrDcBE91w', 'EXS2OfeuyVxeotMtNFGN4M4Qz3c6p8Ns83wcOCuOqbo'  
  provider :facebook, '469447969806333', '686ab1a7de710e537a7a30071e941640' , {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
end  