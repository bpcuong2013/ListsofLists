class ServicesController < ApplicationController
  before_filter :authenticate_user!, :except => [:create]
  def index
    @already_sent_email = false
    @email = ""
    @error_message = ""
    
    begin
      if request.post? || session[:user_login_service] != "twitter"
        @email = current_user.email
        if session[:user_login_service] == "twitter"
          @email = params[:email]
        end
        
        session[:user_login_email] = @email
        puts "Sending usage link to user's email. " + @email
        @host = ActionMailer::Base.default_url_options[:host]
        current_user.usage_security_token = SecureRandom.uuid
        current_user.save
        @usage_link = @host + "/home/" + current_user.usage_security_token
        @message_body = "To continue use the ListsofLists Website, please click on the link <a href='" + @usage_link + "'>Use ListsofLists Web</a>"
        ActionMailer::Base.mail(:from => ActionMailer::Base.smtp_settings[:user_name], :to => @email, :subject => "FoundDataReport Website Usage Link", :body => @message_body, content_type: "text/html").deliver
        @already_sent_email = true
      end
      rescue Exception => ex
        @error_message = ex.message
    end    
  end
  
  def create
    # get the full hash from omniauth
    omniauth = request.env['omniauth.auth']
    omniauth['provider'] ? service_route = omniauth['provider'] : service_route = 'no service (invalid callback)'
    session[:user_login_service] = ""
    
    # continue only if hash and parameter exist
    if omniauth
    else
      flash[:error] = 'Error while authenticating via ' + service_route.capitalize + '.'
      redirect_to new_user_session_path
    end
  end
end
