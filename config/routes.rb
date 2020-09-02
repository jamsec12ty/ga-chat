Rails.application.routes.draw do

  get 'requests/index'
  # ----------------------- Root ----------------------- #
  root to: 'session#new'
  get "/login" => "session#new"

  # ----------------------- Session ----------------------- #
  get "/login" => "session#new" # Login form
  post "/login" => "session#create" # Form submits here, do authentication & create session, redirect or show form with errors
  delete "/login" => "session#destroy" # Logout, delete session

  # ----------------------- Users ----------------------- #
  get "/users/search/:query" => "users#user_search"

  resources :users do
    # ----------------------- Friends ----------------------- #
    resources :friends
    # ----------------------- Requests ----------------------- #
    resources :requests
  end

  # ----------------------- Messages ----------------------- #
  get "/messages/search" => "messages#message_search"
<<<<<<< HEAD
  get "/messages/show/:query" => "messages#message_show"
  
=======

>>>>>>> e65967197121743fd9c8a507fca39b11c768a21f
  resources :messages



end
