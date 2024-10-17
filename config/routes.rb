Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"
  get "user_profiles/show"
  get "user_profiles/update"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root to: ""

  # Routes
  get "signup" => "users#new"
  post "signup" => "users#create"
  resources :users

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  #get "users/:id/profile" => "user_profiles#show", as: :show_user_profile

  #get "users/:id/profile/update" => "user_profiles#edit", as: :edit_user_profile
  #post "users/:id/profile/update" => "users#update", as: :update_user_profile

  get "dashboard" => "dashboard#show", as: :dashboard
end
