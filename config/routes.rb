Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'
  get 'contact', to: 'pages#contact'

  resources :users, only: [:show, :update]
  get 'dashboard', to: 'users#dashboard', as: 'dashboard'
  get 'preferences', to: 'users#preferences', as: 'preferences'
  get 'analytics', to: 'users#analytics', as: 'analytics'

  get 'map', to: 'entries#map', as: 'map'
  resources :entries

  resources :tags, only: [:create] #janette removing the update method
  resources :reminders, only: [:create, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
