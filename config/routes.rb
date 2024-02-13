Rails.application.routes.draw do
  resources :tests
  get 'likes/create'
  get 'likes/destroy'
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users do
    post 'upload', on: :member
  end

  resources :friends do
    patch 'update_friendship', on: :member
  end

  resources :likes, only: %i[create destroy]

  resources :comments

  resources :posts

  resources :notifications

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live. get 'up' => 'rails/health#show', as: :rails_health_check Defines the root path route ("/")
  root 'posts#index'
end
