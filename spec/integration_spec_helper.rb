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
            uid: '12',
            info: {
                username: 'Example User',
                email: 'hz2712@columbia.edu',
                password: 'MyDummyPassword',
                uid: '12',
                provider: 'google_oauth2'
            },
            credentials: {
              token: "123456",
              expires_at: Time.now + 1.week
            }
          })
        end
    end
end
  