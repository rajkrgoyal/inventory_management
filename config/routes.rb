Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'
  resources :products, except: %I[show destroy]
  resources :warehouses, only: %I[new create]
end
