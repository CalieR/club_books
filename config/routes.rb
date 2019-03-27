Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  resources :books, only: [:show, :index]
  resources :memberships, only: [:create, :update, :delete]
  resources :users, except: [:edit, :update, :index]
  resources :reviews, only: [:new, :create]
  resources :clubs do
    resources :meetings, except: [:show, :index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
