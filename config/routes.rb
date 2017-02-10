Rails.application.routes.draw do
  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#index'

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks', :registrations => 'users/registrations'}

end
