Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
  get 'similar_movies/:title' => 'movies#director_same', as: :same_director_movies
end
