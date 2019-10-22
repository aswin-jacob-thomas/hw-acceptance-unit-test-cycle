Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
  get 'movies/:id/search_similar_movies/' => 'movies#search', as: :search_similar_movies
end
