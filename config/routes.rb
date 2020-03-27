Rails.application.routes.draw do
  root 'sessions#new'
  resources :sessions, only: [:new, :create]
  resources :users, only: [:show]

  get '/group_transactions', to: 'transactions#group_transactions'
end
