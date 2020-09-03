Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Home route links to the root of the server
  root to: 'welcome#homepage'

  get '/auth/github/callback', to: "sessions#omniauth"
  post '/signin/omniauth', to: "sessions#omniauth_create"

  get '/auth/facebook/callback', to: "sessions#omniauth"
  post '/signin/omniauth', to: "sessions#omniauth_create"

  get '/signin', to: "sessions#new"
  post '/signin', to: "sessions#create"
  post '/signout', to: "sessions#destroy"



  resources :admins
  resources :babysitters

  resources :parents do 
    resources :children
  end

  resources :appointments
  
end
