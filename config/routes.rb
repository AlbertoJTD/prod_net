require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  mount Sidekiq::Web => '/sidekiq'

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "products#index"

  resources :products do
    collection do
      get :search
    end

    resources :comments, only: %i[create destroy] do
      resources :votes, only: %i[create]
    end
    resources :votes, only: %i[create]
  end
  resources :categories
  resources :comments, only: %i[edit update destroy]
end
