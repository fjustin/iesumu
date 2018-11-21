Rails.application.routes.draw do
  devise_for :users
  resources :houses
  resources :users, :only => [:index,:show]
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'page#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
