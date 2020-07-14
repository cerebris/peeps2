Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  jsonapi_resources :contacts
  jsonapi_resources :phone_numbers

  post '/contacts/:id/publish', action: :publish, controller: :contacts
end
