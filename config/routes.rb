Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'store/index'
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root to: 'store#index', as: 'store'
  namespace :admin_user do
    root to: 'store#index'
  end
end
