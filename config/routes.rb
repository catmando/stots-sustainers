Rails.application.routes.draw do
  mount Hyperstack::Engine => '/hyperstack'  # this route should be first in the routes file so it always matches

  resources :incoming_messages, only: [:create]
  get '/(*others)', to: 'hyperstack#app'
end
