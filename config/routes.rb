Rails.application.routes.draw do
  resources :users
  resources :houses
  resources :reservations
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
