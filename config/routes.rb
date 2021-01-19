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
    resources :likes, only: [:create, :destroy], controller: 'posts/likes'
    resources :comments, only: [:create, :edit, :destroy, :update], controller: 'posts/comments'
  end
end
