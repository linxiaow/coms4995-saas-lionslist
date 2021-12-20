require 'rails_helper'
require 'spec_helper'
require 'integration_spec_helper'

# RSpec.describe Comment, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe SessionsController, type: :request do 
  include IntegrationSpecHelper 
  describe "creates" do
    before(:each) do
      login_with_oauth
      get "/auth/google_oauth2/callback"
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    it "comment with valid parameters" do
      post = Post.create(:title => "Post Title #1",
        :category => "furniture", :content => "I posted something.")
      post.author_id = 1
      post.save
      post "/post/#{post.id}", {:comment => {:content => "This is a comment."}}
      expect(response).to redirect_to show_post_path

      expect(flash[:notice]).to match(/Your comment was successfully created./)
      Post.find_by(:title => "Post Title #1").destroy
    end
  end
end
