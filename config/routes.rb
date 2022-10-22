Rails.application.routes.draw do
  #resources :recipes, only: [:index, :create]
  get "/recipes", to: "recipes#index"
  post "/recipes", to: "recipes#create"
  post "/signup", to: "users#create"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/me", to: "users#show"
end
