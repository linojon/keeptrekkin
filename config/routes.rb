Rails.application.routes.draw do

  resources :trips

  resources :hikers

  resources :mountains

  # root 'welcome#index'

end
