class UsersController < ApplicationController
    skip_before_action :require_login, except: [:show, :show_other, :edit, :update]
    def show
        @user = User.find(session[:user_id])
        @current_user_id = @user.id
        @posts = Post.search_author(session[:user_id])
        @purchase_deals = Deal.search_purchase_requests(session[:user_id])
        puts "hit1"
        puts @purchase_deals
        @selling_deals = Deal.search_selling_requests(session[:user_id])
        puts "hit2"
        puts @selling_deals
        @unrated_deals = Deal.search_unrated_deal(session[:user_id])
        puts "hit3"
        puts @unrated_deals
        @involved_deals = Deal.search_involved_deal(session[:user_id])
        puts "hit4"
        puts @involved_deals
        @user_rating = Deal.calcualte_rating(session[:user_id])
        puts "hit5"
        puts @involved_deals
        render "show"
    end

    def show_other
        other_id = params[:id]
        @user = User.find(other_id)
        @current_user_id = session[:user_id]
        @posts = Post.search_author(other_id)
        @purchase_deals = Deal.search_purchase_requests(session[:user_id])
        @selling_deals = Deal.search_selling_requests(session[:user_id])
        @unrated_deals = Deal.search_unrated_deal(session[:user_id])
        @involved_deals = Deal.search_involved_deal(session[:user_id])
        @user_rating = Deal.calcualte_rating(session[:user_id])
        render "show_other"
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
