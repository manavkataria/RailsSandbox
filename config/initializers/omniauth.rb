#OmniAuth.config.logger = Rails.logger

#TODO: Setup different apps for dev vs production
#TODO: Why does config/facebook.yml need to be placed in .gitignore? 

Rails.application.config.middleware.use OmniAuth::Builder do
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  provider :facebook, FACEBOOK_CONFIG['APP_ID'], FACEBOOK_CONFIG['APP_SECRET'], scope: FACEBOOK_CONFIG["APP_PERMISSIONS"]
  #provider :facebook, 468709936505848, '739b6b648966f731c8d7f68c275ff7fd'	
  #provider :facebook, 468709936505848, '739b6b648966f731c8d7f68c275ff7fd',  {:client_options => {:ssl => {:ca_file => "/opt/local/share/curl/curl-ca-bundle.crt"}}}
end
