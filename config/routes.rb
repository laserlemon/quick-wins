Rails.application.routes.draw do
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  put "mark-read" => "messages#mark_read", as: :mark_read_messages
  root to: "messages#index", as: :messages
end
