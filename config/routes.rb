ListsofLists::Application.routes.draw do

  devise_for :users,
                :path => 'accounts',
                :path_names =>  {
                                      :sign_in        => "login",
                                      :sign_out       => "logout",
                                      :sign_up        => "register",
                                      :password       => "secret",
                                      :confirmation   => "verification"
                                }

  root :to                                      => 'services#index'
  get '/'                                       => 'services#index'
  post '/'                                      => 'services#index'
  match '/accounts/auth/facebook/callback'      => 'services#create'
  match '/accounts/auth/google_oauth2/callback' => 'services#create'
  match '/accounts/auth/twitter/callback'       => 'services#create'
  get   '/home/:usage_security_token'           => 'report#index'
end
