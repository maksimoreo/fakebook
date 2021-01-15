Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'users#index'
  resources :users, only: [:index, :show]

  resources :friends, only: [:index, :destroy]
  resources :incoming_friendship_requests, only: [:index, :update, :destroy]
  resources :sent_friendship_requests, only: [:index, :create, :destroy]
end
