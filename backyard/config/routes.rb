Rails.application.routes.draw do
  get 'messages/', to: 'messages_page#index'
  get '/', to: 'signin_page#form'
  post '/', to:  'signin_page#validate'
  root 'signin_page#form'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end