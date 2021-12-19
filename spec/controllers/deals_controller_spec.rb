require 'rails_helper'
require 'spec_helper'
require 'integration_spec_helper'

# RSpec.describe Comment, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe SessionsController, type: :request do 
  include IntegrationSpecHelper 
  describe "deals:create" do
    before(:each) do
      login_with_oauth
      get "/auth/google_oauth2/callback"
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    it "creates a new deal" do
        post = Post.create(:title => "Sofa",
          :category => "furniture", :content => "Selling sofa.")
        post.author_id = 123
        post.save
  
        post "/posts/#{post.id}/deals/new"
        expect(response).to redirect_to profile_path
  
        expect(flash[:notice]).to match(/A new deal is submitted/)
        Post.find_by(:title => "Sofa").destroy
    end
  end

  describe "deals:delete" do
    before(:each) do
      login_with_oauth
      get "/auth/google_oauth2/callback"
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    it "delete a deal" do
        # post = Post.create(:title => "Sofa",
        #   :category => "furniture", :content => "Selling sofa.")
        # post.author_id = 123
        # post.save
  
        # post "/posts/#{post.id}/deals/new"
        # expect(response).to redirect_to profile_path
        
        deal = Deal.create(:title => 'Sofa', 
            :buyer_id=> '123', :buyer_name => 'Example User',
            :seller_id=> '1', :seller_name => 'Seller',
            :status => 'unsettled', :rating => '-1')
        deal.save
        delete "/deals/#{deal.id}"
        expect(flash[:notice]).to match(/Deal '#{deal.title}' is cancelled./)
    end
  end

  describe "deals:update" do
    before(:each) do
      login_with_oauth
      get "/auth/google_oauth2/callback"
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    it "accept a deal from the buyer" do
        # post = Post.create(:title => "Sofa",
        #   :category => "furniture", :content => "Selling sofa.")
        # post.author_id = 123
        # post.save
  
        # post "/posts/#{post.id}/deals/new"
        # expect(response).to redirect_to profile_path
        post = Post.create(:title => "Sofa",
            :category => "furniture", :content => "Selling sofa."
        )
        post.author_id = 123
        post.save
        deal = Deal.create(:title => 'Sofa', 
            :buyer_id=> '1', :buyer_name => 'Seller',
            :seller_id=> '123', :seller_name => 'Example User',
            :status => 'unsettled', :rating => '-1',
            :post_id => post.id)
        deal.save
        post "/deals/#{deal.id}"
        expect(response).to redirect_to profile_path
        expect(flash[:notice]).to match(/Deal '#{deal.title}' is accepted./)
    end

    it "accept a deal and decline other deals" do
        # post = Post.create(:title => "Sofa",
        #   :category => "furniture", :content => "Selling sofa.")
        # post.author_id = 123
        # post.save
  
        # post "/posts/#{post.id}/deals/new"
        # expect(response).to redirect_to profile_path
        post = Post.create(:title => "Sofa",
            :category => "furniture", :content => "Selling sofa."
        )
        post.author_id = 123
        post.save
        deal1 = Deal.create(:title => 'Sofa', 
            :buyer_id=> '1', :buyer_name => 'Buyer',
            :seller_id=> '123', :seller_name => 'Example User',
            :status => 'unsettled', :rating => '-1',
            :post_id => post.id)
        deal1.save

        deal2 = Deal.create(:title => 'Sofa', 
            :buyer_id=> '2', :buyer_name => 'Buyer2',
            :seller_id=> '123', :seller_name => 'Example User',
            :status => 'unsettled', :rating => '-1',
            :post_id => post.id)
        deal2.save

        post "/deals/#{deal1.id}"
        expect(response).to redirect_to profile_path
        expect(flash[:notice]).to match(/Deal '#{deal1.title}' is accepted./)

        expect(Deal.find_by(:buyer_id => '1').status).to eq('accepted')
        expect(Deal.find_by(:buyer_id => '2').status).to eq('declined')
        
        # will delete associated deal as well
        Post.find_by(:title => "Sofa").destroy
    end
  end

  describe "deals:rate" do
    before(:each) do
      login_with_oauth
      get "/auth/google_oauth2/callback"
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    it "rate a deal" do
        # post = Post.create(:title => "Sofa",
        #   :category => "furniture", :content => "Selling sofa.")
        # post.author_id = 123
        # post.save
  
        # post "/posts/#{post.id}/deals/new"
        # expect(response).to redirect_to profile_path
        post = Post.create(:title => "Sofa",
            :category => "furniture", :content => "Selling sofa."
        )
        post.author_id = 123
        post.save
        deal = Deal.create(:title => 'Sofa', 
            :buyer_id=> '123', :buyer_name => 'Example User',
            :seller_id=> '1', :seller_name => 'Seller',
            :status => 'accepted', :rating => '-1',
            :post_id => post.id)
        deal.save
        post "/deals/#{deal.id}/rate", {:rating => '4'}

        expect(Deal.find_by(:buyer_id => '123').rating).to eq(4)

        expect(response).to redirect_to profile_path
        expect(flash[:notice]).to match(/Deal '#{deal.title}' is rated./)
        # will delete associated deal as well
        Post.find_by(:title => "Sofa").destroy
    end
  end


  describe "post:destroy" do
    before(:each) do
      login_with_oauth
      get "/auth/google_oauth2/callback"
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    it "mark all the deals as declined" do
        # post = Post.create(:title => "Sofa",
        #   :category => "furniture", :content => "Selling sofa.")
        # post.author_id = 123
        # post.save
  
        # post "/posts/#{post.id}/deals/new"
        # expect(response).to redirect_to profile_path
        post = Post.create(:title => "Sofa",
            :category => "furniture", :content => "Selling sofa."
        )
        post.author_id = 123
        post.save
        deal = Deal.create(:title => 'Sofa', 
            :buyer_id=> '1', :buyer_name => 'Buyer',
            :seller_id=> '123', :seller_name => 'Example User',
            :status => 'unsettled', :rating => '-1',
            :post_id => post.id)
        deal.save
        delete "/posts/#{post.id}"

        expect(Deal.find_by(:seller_id => '123').status).to eq('declined')
        # will delete associated deal as well
        Post.find_by(:title => "Sofa").destroy
    end
  end

end
