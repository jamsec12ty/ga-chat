Rails.application.routes.draw do

  # ----------------------- Root ----------------------- #
  root to: 'session#new'
  get "/login" => "session#new"

  # ----------------------- Session ----------------------- #
  get "/login" => "session#new" # Login form
  post "/login" => "session#create" # Form submits here, do authentication & create session, redirect or show form with errors
  delete "/login" => "session#destroy" # Logout, delete session

  # ----------------------- Users ----------------------- #
  resources :users

  # ----------------------- Messages ----------------------- #
  resources :messages
  
  get "/messages/search/:query" => "messages#message_search"

end
