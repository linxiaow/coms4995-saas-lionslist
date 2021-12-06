Rottenpotatoes::Application.routes.draw do
  resources :posts
  #get '/movies/:id/search_directors' => 'movies#show_same_director', as: :search_directors
  # map '/' to be a redirect to '/movies'
  # Routes for Google authentication
  root :to => redirect('/posts')
  post 'posts/new' => 'posts#create'
  post 'posts/:id/edit' => 'posts#update'
  post 'posts/:id/deals/new' => 'deals#create', as: 'add_deal'
  post '/deals/:id' => 'deals#update', as: 'accept_deal'
  post '/deals/:id/rate' => 'deals#rate', as: 'rate_deal'
  get 'posts/:id' => 'posts#show', as: 'show_post'
  get '/auth/:provider/callback' => 'sessions#omniauth'
  get 'auth/failure', to: redirect('/')
  get '/profile', to: 'users#show', as: 'profile'
  get '/profile/:id', to: 'users#show_other', as: 'other_profile'
  put '/profile', to: 'users#update', as: 'update_profile'
  get '/edit/profile', to: 'users#edit', as: 'edit_profile'
  get '/error', to: 'users#error', as: 'error'
  get '/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'
  delete '/posts/:id' => 'posts#destroy', as: 'delete_post'
  delete '/deals/:id' => 'deals#destroy', as: 'cancel_deal'
  
  post 'post/:id' => 'comments#create', as: 'add_comment'
end
