Rails.application.routes.draw do

  root "portfolios#index"

  get "trades/index" => "trades#index"

  devise_for :users
  resources :posts
  resources :portfolios
  resources :assets


  get ":trades/new" => "trades#new"

  get ":username" => "users#show", as: :user

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
