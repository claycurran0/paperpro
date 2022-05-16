Rails.application.routes.draw do

  
  root "portfolios#index"

  devise_for :users
  resources :posts
  resources :portfolios
  resources :assets
  

  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
