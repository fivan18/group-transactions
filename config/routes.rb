Rails.application.routes.draw do
  devise_for :users
  root 'transactions#group_transactions'
  resources :users, only: [:show]
  resources :transactions, only: [:new, :create]
  resources :groups, only: [:new, :create]

  get '/group_transactions', to: 'transactions#group_transactions'
end
