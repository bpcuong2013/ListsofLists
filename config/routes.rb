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

  root :to                                      => 'favorite_list#index'
  get '/'                                       => 'favorite_list#index'
  get '/favorite_list/get_favorite_list'        => 'favorite_list#get_favorite_list'
  get '/favorite_list/spellcheck_list'          => 'favorite_list#spellcheck_list'
  get '/favorite_list/spellcheck_item'          => 'favorite_list#spellcheck_item'
  match '/accounts/auth/facebook/callback'      => 'services#create'
  match '/accounts/auth/google_oauth2/callback' => 'services#create'
  match '/accounts/auth/twitter/callback'       => 'services#create'
end
