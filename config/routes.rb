Rails.application.routes.draw do

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  match 'auth/hack', to: 'sessions#hack', via: :get
  
  resources :trips do
    resources :hikers, only: [:create]
  end
  
  match 'dashboard', to: 'trips#index', as: :dashboard, via: :get

  resources :hikers
  match 'profile', to: 'hikers#profile', via: :get
  match 'profile/edit', to: 'hikers#profile_edit', as: 'edit_profile', via: :get


  resources :mountains

  root 'pages#home'

end
