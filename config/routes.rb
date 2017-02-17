Rails.application.routes.draw do
  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'events#index'

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks', :registrations => 'users/registrations'}
  resources :events
  get '/users/:id', :to => 'users#show', :as => :user
  resources :users do
    member do
      get :attended_events, :created_events
    end
  end
  resources :attendance_relations,       only: [:create, :destroy]
end
