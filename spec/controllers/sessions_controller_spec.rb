require 'rails_helper'
require 'spec_helper'
require 'integration_spec_helper'

RSpec.describe SessionsController, type: :request do 
  include IntegrationSpecHelper 

  describe "logout" do
    it "log out current user" do
      login_with_oauth
      get "/auth/google_oauth2/callback"
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
      delete '/logout'
#       expect(response).to redirect_to posts_path
#       expect(flash[:notice]).to match(/Toucan Play This Game was successfully created./)
      # Post.find_by(:title => "Post Title #3").destroy
      expect(response).to redirect_to root_path
      expect(flash[:notice]).to match(/logged out/)
    end
  end

end