require 'rails_helper'
require 'spec_helper'
require 'integration_spec_helper'

RSpec.describe SessionsController, type: :request do 
  include IntegrationSpecHelper 
  describe "creates" do
    before(:each) do
      login_with_oauth
      get "/auth/google_oauth2/callback"
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    it "post with valid parameters" do
      post "/posts/new", {:post => {:title => "Post Title #1",
                    :category => "furniture", :content => "I posted something."}}
      expect(response).to redirect_to posts_path

      expect(flash[:notice]).to match(/Post Title #1 was successfully created./)
      Post.find_by(:title => "Post Title #1").destroy
    end
  end
  
  describe "updates" do
    it "post's valid attributes" do
      login_with_oauth
      get "/auth/google_oauth2/callback"
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
      post = Post.create(:title => "Post Title #2",
                    :category => "furniture", :content => "I posted some other things.")
      post "/posts/#{post.id}/edit", {:id => post.id, :post =>
        {:content => "content changed to some other things."}
      }
      expect(response).to redirect_to post_path(post)
      expect(flash[:notice]).to match(/Post Title #2 was successfully updated./)
      post.destroy
    end
  end

  describe "destroys" do
    it "deletes a post" do
      login_with_oauth
      get "/auth/google_oauth2/callback"
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]

      post = Post.create(:title => "Post Title #3", :author => "Author #3",
                    :category => "furniture", :content => "I posted some other things.")
      post.author_id = 1
      post.save
      delete "/posts/#{post.id}"
      expect(response).to redirect_to posts_path
      expect(flash[:notice]).to match(/'Post Title #3' deleted./)
    end
  end


  describe 'index' do

    it 'renders the index template' do
      get '/posts'
      expect(response).to render_template('index')
    end
  end
  
  describe 'show' do
    before(:each) do
      login_with_oauth
      get "/auth/google_oauth2/callback"
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end
    it 'shows the post' do
      post = Post.create(:title => "Post Title #2",
        :category => "furniture", :content => "I posted some other things.")
      post.author_id = 1
      post.save
      get "/posts/#{post.id}"
      expect(response).to render_template('show')
      # expect(page.body).to match(/Post Title #2/)
      # expect(page.body).to match(/furniture/)
      # expect(page.body).to match(/I posted some other things./)
      post.destroy
    end

    # it 'finds the post' do
    #   expect(assigns(:post)).to eql(post)
    # end

    # it 'renders the show template' do
    #   expect(response).to render_template('show')
    # end
  end

end