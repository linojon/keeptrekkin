Rails.application.routes.draw do

  resources :trips

  resources :hikers

  resources :mountains

  root 'pages#home'

end
