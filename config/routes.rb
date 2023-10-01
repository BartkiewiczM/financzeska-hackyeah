Rails.application.routes.draw do
  root 'chat#index'
  post 'chat/send_message'
  resources :institutions, only: [:index]
end
