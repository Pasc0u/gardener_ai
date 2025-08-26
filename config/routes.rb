Rails.application.routes.draw do
  get 'messages/index'
  get 'messages/new'
  get 'messages/create'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "pages#home"
  resources :plants, only: [:index, :new, :create, :show] do
    resources :chats, only: [:create]
  end
  resources :chats, only: [:show] do
    resources :messages, only: [:index, :new, :create]
  end
  # post "plants/:plant_id/chats", to: "chats#create"
  # get "chats/:id", to: "chats#show", as: :chat
  # get "chats/:chat_id/messages", to: "messages#index"
  # get "chats/:chat_id/messages/new", to: "messages#new",
  # post "chats/:id/messages", to: "messages#create"
end
