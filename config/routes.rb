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
  get "/users/profile/:query" => "users#user_profile"

  resources :users do
    # ----------------------- Friends ----------------------- #
    resources :friends
    # ----------------------- Requests ----------------------- #
    resources :requests
  end

  # ----------------------- Messages ----------------------- #
  get "/messages/search" => "messages#message_search"
  get "/messages/show/:query" => "messages#message_show"
  
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
  
  post "/messages" => "messages#create"
  resources :messages

end
