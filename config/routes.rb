Rails.application.routes.draw do

  get 'signin', to: redirect('/auth/facebook'), as: :signin
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  match 'auth/hack', to: 'sessions#hack', via: :get
  get 'who', to: 'sessions#who', as: :who_sessions
  get 'iam', to: 'sessions#iam', as: :iam_sessions
  
  resources :trips do
    resources :hikers, only: [:create]
    collection do
      get :everyone
      get :me
    end
  end
  
  match 'trips', to: 'trips#index', as: :newsfeed, via: :get # generic name "newsfeed" gives us some flexilbity in nav menus, redirects etc

  resources :hikers

  resources :mountains

  resources :activities

  mount Attachinary::Engine => "/attachinary"

  root 'pages#home'

  match 'legalese', to: 'pages#legalese', as: :legalese, via: :get
  match 'test_email', to: 'pages#test_email', as: :test_email, via: :get

  match '/contacts', to: 'contacts#new', via: 'get'
  resources "contacts", only: [:new, :create]

end
