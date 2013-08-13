Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/', to: 'pages#front'
  get 'home', to: 'pages#home'
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'

  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
  end

  resources :categories, only: [:show]

  resources :users, only: [:create]
end