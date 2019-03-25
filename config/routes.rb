Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  resources :meetings, except: [:show, :index]
  resources :books, only: [:show, :index]
  resources :memberships, only: [:create, :update, :delete]
  resources :users, except: [:edit, :update, :index]
  resources :clubs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
