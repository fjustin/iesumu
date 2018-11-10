Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  resources :houses
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'page#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
