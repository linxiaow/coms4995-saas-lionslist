class UsersController < ApplicationController
    skip_before_action :require_login, except: [:show, :show_other, :edit, :update]
    def show
        @user = User.find(session[:user_id])
        @posts = Post.search_author(session[:user_id])
    end

    def show_other
        other_id = params[:id]
        @user = User.find(other_id)
        @posts = Post.search_author(other_id)
    end

    def edit
        @user = User.find(session[:user_id])
    end

    def update
        @user = User.find(session[:user_id])
        @user.update_attributes!(user_params)
        flash[:notice] = "#{@user.username}'s personal profile was successfully updated."
        redirect_to profile_path
    end

    def error
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password, :phone, :address, :description)
    end
end
