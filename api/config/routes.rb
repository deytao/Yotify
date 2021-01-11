Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  devise_for :users
  get '/users/:id', to: 'user#show'
  resources :messages
  resources :notifications
  root 'messages#index'
end
