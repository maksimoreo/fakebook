Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'users#index'
  resources :users, only: [:index, :show]

  resources :friendships, only: [:create, :destroy, :index] do
    member do
      patch 'accept'
    end

    collection do
      get 'incoming_requests'
    end
  end
end
