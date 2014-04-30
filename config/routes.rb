Rails.application.routes.draw do
  resources :messages, only: [:index] do
    put "mark-read", on: :collection
  end
end
