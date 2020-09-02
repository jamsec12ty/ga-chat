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
  get "/messages/show/:query" => "messages#message_show"
  post "/messages" => "messages#create"
  
  resources :messages

end
