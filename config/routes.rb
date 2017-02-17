Rails.application.routes.draw do
  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'events#index'

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks', :registrations => 'users/registrations'}
  #resources :events
  resources :events do
    member do
      put "attend",   to: "events#attend"
      put "unattend", to: "events#unattend"
    end
  end
  get '/users/:id', :to => 'users#show', :as => :user

end
