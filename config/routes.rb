Rails.application.routes.draw do
  mount Hyperstack::Engine => '/hyperstack'  # this route should be first in the routes file so it always matches

  # access progress web app manifest and worker
  get '/(*others)', to: 'hyperstack#app'
end
