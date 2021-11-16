class UsersController < ApplicationController
    skip_before_action :require_login, except: [:show]
    def show
        @user = User.find(params[:id])
    end

    def error
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
