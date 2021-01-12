Rails.application.routes.draw do
  post 'oauth/token'
  get '/notifications', to: 'notifications#index'
  get '/notifications/:id', to: 'notifications#show'
  get '/portfolios', to: 'portfolios#index'
  get '/portfolios/:id', to: 'portfolios#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
