Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/', to: 'pages#front'
  get 'home', to: 'pages#home'

  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
  end

  resources :categories, only: [:show]
end