require 'simplecov'
SimpleCov.start 'rails'
require 'rails_helper'
require 'integration_spec_helper'
require 'rspec/rails'
# Capybara integration
require 'capybara/rspec'
require 'capybara/rails'

module IntegrationSpecHelper
    def login_with_oauth(service = :google_oauth2)
        if Rails.env.test?
          OmniAuth.config.test_mode = true
          OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
            provider: 'google_oauth2',
            uid: '123',
            info: {
                username: 'Example User2',
                email: 'hcass@columbia.edu',
                password: 'MyDummyPassword2',
                uid: '123',
                provider: 'google_oauth2'
            },
            credentials: {
              token: "156234",
              expires_at: Time.now + 1.week
            }
          })
        end
    end
end
  