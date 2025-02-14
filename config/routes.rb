Rails.application.routes.draw do
  get "users/index"

  mount ActionCable.server => '/cable'
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, only: [:index]

  # Defines the root path route ("/")
  # root "posts#index"
end
