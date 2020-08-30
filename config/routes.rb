Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Home route links to the root of the server
  root to: 'welcome#homepage'

  get '/signin', to: "sessions#new"
  post '/signin', to: "sessions#create"
  post '/signout', to: "sessions#destroy"
  resources :admin
  resources :babysitters
  resources :parents
end
