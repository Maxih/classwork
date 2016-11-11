Rails.application.routes.draw do

  resources :users, only: [:create, :new]

  resource :session, only: [:create, :new, :destroy]

  resources :subs do
    resources :posts, only: [:new]
  end

  resources :posts, only: [:create, :destroy, :show, :edit, :update] do
    resources :comments, only: [:new]
  end

  resources :comments, only: [:destroy, :create, :update]
end
