Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :facebook, '644473238897361', '433f4574a7cc28dd670886b4c5175dc6'  
  provider :google_oauth2, '1027665096433.apps.googleusercontent.com','VC0aEfQMINad1wNNSTEYq9YB'
  provider :twitter, 'TTNBI2EFPDb8M4TkZMww', 'kjQO578wIagDNVzdDex9j1nb1Ipk1bV9FXQRbk4hRc'
end