class UsersController < ApplicationController
    skip_before_action :require_login
    def show
        @user = User.find(params[:id])
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
