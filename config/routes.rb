Rails.application.routes.draw do
  root 'chat#index'
  post 'chat/send_message'
  resources :faqs
end
