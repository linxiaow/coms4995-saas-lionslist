require 'rails_helper'
require 'spec_helper'
require 'integration_spec_helper'

RSpec.describe SessionsController, type: :request do
    include IntegrationSpecHelper
  
  describe "user_profile:updates" do
    it "user's valid attributes" do
        login_with_oauth
        get "/auth/google_oauth2/callback"
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
        put "/profile", {:user =>
        {:phone => "123456"}
        }
        expect(response).to redirect_to profile_path
        expect(flash[:notice]).to match(/'s personal profile was successfully updated./)
    end
  end

describe 'user_profile:edit' do
    before do
        login_with_oauth
        get "/auth/google_oauth2/callback"
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
        get "/edit/profile"
    end

    it 'finds the user' do
        expect(assigns(:user)).not_to be nil
    end

    it 'renders the edit template' do
        expect(response).to render_template('edit')
    end
end
  
describe 'user_profile:show' do
    before(:each) do
        login_with_oauth
        get "/auth/google_oauth2/callback"
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
        get "/profile"
    end

    it 'finds the user and posts' do
        expect(assigns(:user)).not_to be nil
        expect(assigns(:posts)).not_to be nil
    end

    it 'renders the show template' do
        expect(response).to render_template('show')
    end
end

describe 'user_profile:show_other' do
    user = FactoryGirl.create(:user)
    before(:each) do
        login_with_oauth
        get "/auth/google_oauth2/callback"
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
        get "/profile/#{user.id}"
    end

    it 'finds the user and posts' do
        expect(assigns(:user)).to eql(user)
        expect(assigns(:posts)).not_to be nil
    end

    it 'renders the show template' do
        expect(response).to render_template('show_other')
    end
end

end