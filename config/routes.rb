Rottenpotatoes::Application.routes.draw do
  resources :posts
  #get '/movies/:id/search_directors' => 'movies#show_same_director', as: :search_directors
  # map '/' to be a redirect to '/movies'
  # Routes for Google authentication
  root :to => redirect('/posts')
  get '/auth/:provider/callback' => 'sessions#omniauth'
  get 'auth/failure', to: redirect('/')
end
