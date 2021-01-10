Rails.application.routes.draw do
  root 'signin_page#form'
  get '/', to: 'signin_page#form'
  post '/', to:  'signin_page#validate'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
