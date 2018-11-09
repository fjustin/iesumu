Rails.application.routes.draw do
  resources :houses
  devise_for :users
  get 'pages/index'
  get 'pages/show'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'page#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
