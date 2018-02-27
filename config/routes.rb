Rails.application.routes.draw do

  resources :dict, only: [:index]

  root to: "home#index"
end
