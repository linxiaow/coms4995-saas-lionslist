Rottenpotatoes::Application.routes.draw do
  resources :posts
  resources :users
  #get '/movies/:id/search_directors' => 'movies#show_same_director', as: :search_directors
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/posts')

  get '/welcome' => 'sessions#welcome'
  # oauth callback
  get '/login' => 'sessions#new'
  get '/signup' => 'users#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/auth/:provider/callback' => 'sessions#omniauth'
end
