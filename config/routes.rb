Rottenpotatoes::Application.routes.draw do
  resources :posts
  #get '/movies/:id/search_directors' => 'movies#show_same_director', as: :search_directors
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/posts')
end
