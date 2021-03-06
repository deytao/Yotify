Rails.application.routes.draw do
  resources :companies
  resources :portfolios
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  devise_for :users
  get '/customers', to: 'customers#index'
  get '/customers/:id', to: 'customers#show'
  get '/users/:id', to: 'user#show'
  resources :messages
  get '/messages/:id/notifications', to: 'notifications#from_message'
  resources :notifications
  get '/customers/:id/notifications', to: 'notifications#from_customer'
  get '/customers/:id/portfolios', to: 'portfolios#from_customer'
  get '/portfolios/:id/positions', to: 'positions#from_portfolio'
  root 'messages#index'
end
