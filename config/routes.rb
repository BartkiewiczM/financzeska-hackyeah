Rails.application.routes.draw do
  resources :institutions, only: [:index]
end
