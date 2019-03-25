Rails.application.routes.draw do
  resources :meetings
  resources :books
  resources :memberships
  resources :users
  resources :clubs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
