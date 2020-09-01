Rails.application.routes.draw do

  # ----------------------- Root ----------------------- #
  root to: 'session#new'
  get "/login" => "session#new"


  # ----------------------- Session ----------------------- #
  get "/login" => "session#new" # Login form
  post "/login" => "session#create" # Form submits here, do authentication & create session, redirect or show form with errors
  delete "/login" => "session#destroy" # Logout, delete session

  # ----------------------- Users ----------------------- #
  get "/users/search/:query" => "users#user_search"
  resources :users

  # ----------------------- Messages ----------------------- #
  resources :messages

  # ----------------------- Friendships ----------------------- #
  resources :friendships

  # ----------------------- Friends ----------------------- #

  resources :friends


end
