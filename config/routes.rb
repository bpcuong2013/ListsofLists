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

  

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
