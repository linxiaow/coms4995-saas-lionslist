class SessionsController < ApplicationController
    skip_before_action :require_login
	def omniauth
	    user = User.from_omniauth(request.env['omniauth.auth'])
	    puts request.env['omniauth.auth']
	    if user.valid?
	    	session[:user_id] = user.id
	    	redirect_to user_path(user)
    	else
    		redirect_to root_path
		end
  	end

  	def destroy
        session.delete(:user_id)
        redirect_to root_path
    end
end