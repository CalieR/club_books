Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  resources :books, only: [:show, :new, :create]
  resources :memberships, only: [:create, :update, :delete]
  resources :users, except: [:edit, :update, :index]
  resources :reviews, only: [:new, :create]
  # meetings nested within clubs routes so that the club id could always be accessed by a meeting - meetings are only ever seen within the context of a club.
  resources :clubs do
    resources :meetings, except: [:show, :index]
  end
  
end
