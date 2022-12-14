# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :categories, only: %i[index create update destroy]

      resources :books, only: %i[index create show update destroy] do
        resources :reviews, only: %i[index create show update destroy]
      end

      # Adding user specific routes as actions
      post 'login', to: 'authentication#create'
      post 'register', to: 'users#create'
    end
  end
end
