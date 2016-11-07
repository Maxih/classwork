Rails.application.routes.draw do
  # resources :users

  get '/users', to: 'users#index'
  post '/users', to: 'users#create'
  get '/users/:id', to: 'users#show'
  patch '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#destroy'

  resources :contacts, only: [:create, :show, :update, :destroy]
  resources :contact_shares, only: [:create, :destroy]

  resources :users do
    resources :contacts, only: [:index]
  end
end
