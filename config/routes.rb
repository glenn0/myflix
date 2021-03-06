 Myflix::Application.routes.draw do
  root to: 'pages#front'

  get 'ui(/:action)', controller: 'ui'
  get 'home', to: 'pages#home'
  get '/', to: 'pages#front'
  get 'register', to: 'users#new'
  get 'register/:token', to: 'users#new_with_invitation', as: 'register_with_invitation'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  get 'my_queue', to: 'queue_items#index'
  get 'people', to: 'relationships#index'
  get 'forgotten_password', to: 'forgotten_passwords#new'
  get 'forgotten_password_confirmation', to: 'forgotten_passwords#confirm'
  get 'invalid_token', to: 'password_resets#invalid'

  post 'update_queue', to: 'queue_items#update_queue'

  namespace :admin do
    resources :videos, only: [:new, :create]
  end

  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
    resources :reviews, only: [:show, :create]
  end

  resources :categories, only: [:show]
  resources :users, only: [:create, :show]
  resources :sessions, only: [:create]
  resources :queue_items, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :forgotten_passwords, only: [:create]
  resources :password_resets, only: [:show, :create]
  resources :invitations, only: [:new, :create]
end