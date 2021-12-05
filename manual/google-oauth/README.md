# OAuth
Note this consent, so it may only be used in Columbia organization if I register with my columbia email for the google develper console

# Steps
## Reinstall gem because more dependencies were added

Add necessary gems to your gem file. You’ll need to add three gems — `gem 'omniauth'`, `gem 'dotenv-rails'` and `gem 'omniauth-google-oauth2'`. Run bundle in the terminal.

```
bundle install --without production
```

## Migrate db again

Also add a new user table, so need to migrate the db again

```
bundle exec rake db:migrate
```
```
bundle exec rake db:migrate:reset
```
## Ask for .env file
This file is very important for local development with Google OAuth ClientID, but is ignored in .gitignore. Ask Haoran or Linxiao for the file

## Try it out
Start the server
```
rails server -b localhost
```

Go to login
```
http://localhost:3000/login
```

Choose `login with google`

Try non-columbia email, it should fail

Try columbia email, it should succeed

After it is successful, it will be redirected back to /posts

# under the hood flow
The flow will look like this:

1. The user GETs /login
2. The user enters their username. There is no password.
3. The user submits the form, POSTing to /login.
4. In the create action of the SessionsController we set a 5. cookie on the user's browser by writing their username into the session hash.

Thereafter, the user is logged in. session[:username] will hold their username.

# Tips
- use `rake routes` to examine the urls
- See https://github.com/rachelkathleen/wine-log for more reference
- Added more controllers and models
- May need to configure user model and controller more

# reference
- https://medium.com/swlh/google-authentication-strategy-for-rails-5-application-cd37947d2b1b
- session controller: https://learn.co/lessons/sessions_controller_readme
- https://www.mintbit.com/blog/social-login-in-ruby-on-rails-with-google
- https://github.com/rachelkathleen/wine-log