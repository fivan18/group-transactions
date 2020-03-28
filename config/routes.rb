Rails.application.routes.draw do
  devise_for :users
  root 'sessions#new'
  resources :sessions, only: [:new, :create]
  resources :users, only: [:show, :new, :create]
  resources :transactions, only: [:new, :create]
  resources :groups, only: [:new, :create]

  get '/group_transactions', to: 'transactions#group_transactions'
end
