Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'contact', to: 'pages#contact'

  get 'dashboard', to: 'users#dashboard', as: 'dashboard'
  get 'preferences', to: 'users#preferences', as: 'preferences'
  get 'analytics', to: 'users#analytics', as: 'analytics'
  resources :users, only: [:show, :edit, :update]

  resources :entries

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
