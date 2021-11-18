require 'rails_helper'
require 'spec_helper'
require 'integration_spec_helper'

RSpec.describe UsersController, type: :controller do
    include IntegrationSpecHelper
  
  describe "updates" do
    it "user's valid attributes" do
      user = User.create(:username => "User1", :email => "user1@gmail.com",
                    :password => "123")
      get :update, {:id => user.id, :user =>
        {:phone => "123456"}
      }
      expect(response).to redirect_to profile_path
      expect(flash[:notice]).to match(/User1's personal profile was successfully updated./)
      user.destroy
    end
  end

  describe 'edit' do
    it 'renders the edit template' do
      get :edit
      expect(response).to render_template('edit')
    end
  end
  
  describe 'show' do
    user = FactoryGirl.create(:user)
    before(:each) do
      get :show
    end

    it 'finds the user' do
      expect(assigns(:user)).to eql(user)
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end
  end

  describe 'show_other' do
    user = FactoryGirl.create(:user)
    before(:each) do
      get :show, id: user.id
    end

    it 'finds the user' do
      expect(assigns(:user)).to eql(user)
    end

    it 'renders the show template' do
      expect(response).to render_template('show_other')
    end
  end

end