ListsofLists::Application.routes.draw do

  devise_for :users,
                :path => 'accounts',
                :path_names =>  {
                                      :sign_in        => "login",
                                      :sign_out       => "logout",
                                      :sign_up        => "register",
                                      :password       => "secret",
                                      :confirmation     => "verification"
                                }

  root :to                                    => 'report#index'
  get '/'                                   => 'report#index'
  match '/accounts/auth/facebook/callback'        => 'report#create'
  match '/accounts/auth/google_oauth2/callback'       => 'report#create'
  match '/accounts/auth/twitter/callback'         => 'report#create'
end
