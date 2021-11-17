class UsersController < ApplicationController
    skip_before_action :require_login, except: [:show]
    def show
        @user = User.find(session[:user_id])
        @posts = Post.search_author(session[:user_id])
    end

    def error
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
