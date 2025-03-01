Rails.application.routes.draw do
  get "users/index"

  mount ActionCable.server => '/cable'
  get "up" => "rails/health#show", as: :rails_health_check

  resources :game_rooms, only: [:create, :show, :update, :destroy]
  resources :session_users, only: [:create]

  # Defines the root path route ("/")
  # root "posts#index"
end
