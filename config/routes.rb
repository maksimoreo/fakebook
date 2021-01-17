Rails.application.routes.draw do
  root to: 'users#index'

  # Users
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show]

  # Friendships
  resources :friends, only: [:index, :destroy]
  resources :incoming_friendship_requests, only: [:index, :update, :destroy]
  resources :sent_friendship_requests, only: [:index, :create, :destroy]

  # Posts
  resources :posts do

  end
end
