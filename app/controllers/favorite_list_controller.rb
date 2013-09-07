class FavoriteListController < ApplicationController
  before_filter :authenticate_user!
  def index
    @usage_security_token = params[:usage_security_token]
    @error_message = ""
    
    begin
      # Verify against database to make sure it's correct
      if @usage_security_token != current_user.usage_security_token
        @error_message = "Access is denied. Please login and follow the message is sent to your email to continue using the system."
      else
        
      end
      rescue Exception => ex
        @error_message = ex.message
    end
  end
end
