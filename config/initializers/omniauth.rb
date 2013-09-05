Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :facebook, '191891907656283', 'a3ee1055a71ccac7e00b5e47890230d5'  
  provider :google_oauth2, '190344210531.apps.googleusercontent.com','rpcxTWvqVoPBeBiBoReatYIt'
  provider :twitter, 'YKYkboAnAxdaGGv57jHw', 'XIh1D7EsWyCdUXybRSCByT4abs1tBwamCc15pH3cg'
end