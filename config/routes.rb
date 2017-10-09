Rails.application.routes.draw do

  root 'home#index'

  resources :rooms
  resources :users  

  resource :confirmation, only: [:show]
  resource :user_sessions, only: [:create, :new, :destroy]
end
