module ApplicationHelper
  def after_sign_in_path_for(resource)
        "/"
    end
    
    def after_sign_out_path_for(resource_or_scope)
        session[:user_login_service] = "" # clear session
        session[:user_login_email] = ""
        respond_to?(:root_path) ? root_path : "/"
    end
end
