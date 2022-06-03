Rails.application.routes.draw do

  root "portfolios#index"


  get "trades/index" => "trades#index"

  get "assets/list" => "assets#list"

  get "create_follow" => "follows#new", as: :new_follow

  devise_for :users
  resources :posts
  resources :portfolios
  resources :assets

  get ":username" => "users#show", as: :user
  
  get ":trades/new" => "trades#new"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
