Rails.application.routes.draw do
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :messages, only: [:index] do
    put "mark-read", on: :collection
  end
end
