Rails.application.routes.draw do
  resources :orders
  resources :line_items
  delete '/carts/:id', to: 'carts#destroy'
  resources :carts
  resources :admin_user_mfa_session, only: [:new, :create]
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'store/index'
  resources :products do
    get :who_bought, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root to: 'store#index', as: 'store'
  namespace :admin_user do
    root to: 'store#index'
  end
end
