Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :facebook, '665261240158184', 'f2885dd99652ad778c9543ef7cd763de'  
  provider :google_oauth2, '361914808375.apps.googleusercontent.com','hU4cfF0Xwpm4XqrvsAKFfagn'
  provider :twitter, 'TTNBI2EFPDb8M4TkZMww', 'kjQO578wIagDNVzdDex9j1nb1Ipk1bV9FXQRbk4hRc'
end