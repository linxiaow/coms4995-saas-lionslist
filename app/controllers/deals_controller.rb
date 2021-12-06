class DealsController < ApplicationController
    skip_before_action :require_login, except: [:create, :destroy, :update, :rate]

    def create
        # deals can only be created by buyer
        puts session
        buyer = User.find(session[:user_id])
        post = Post.find(params[:id])
        deal = post.deals.build()
        deal.title = post.title
        deal.buyer_id = session[:user_id]
        deal.buyer_name = buyer.username

        deal.seller_id = post.author_id
        deal.seller_name = post.author
        deal.status = "unsettled"
        deal.rating = -1
        deal.save
        flash[:notice] = "A new deal is submitted"
        redirect_to profile_path
    end

    def destroy
        deal = Deal.find(params[:id])
        deal.destroy
        flash[:notice] = "Deal '#{deal.title}' is cancelled."
        redirect_to profile_path
    end

    def update
        # accept a deal
        deal = Deal.find(params[:id])
        deal.status = 'accepted'
        deal.save

        # all other deals with the same post id should be rejected
        all_requests = Deal.get_all_unsettled_requests_from_post_id(deal.post_id)
        all_requests.each do |request|
            if request.id != deal.id
                puts request.title
                puts request.id
                request.status = 'declined'
                request.save
            end
        end
        
        # make post offshelf
        post = Post.find(deal.post_id)
        post.onshelf = 0
        post.save

        flash[:notice] = "Deal '#{deal.title}' is accepted."
        redirect_to profile_path
    end

    def rate
        # Make a rating
        deal = Deal.find(params[:id])
        # rating = params[:deal][:rating]
        rating = params[:rating]
        deal.rating = rating.to_i
        deal.save
        flash[:notice] = "Deal '#{deal.title}' is rated."
        redirect_to profile_path
    end

    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    # def deal_params
    #     params.require(:deal).permit(:title, :status)
    # end
end 