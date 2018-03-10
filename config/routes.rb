Rails.application.routes.draw do

  resources :dict, only: [:index] do
    collection do
      get :search
    end
  end

  resources :trivia, only: [:index]

  root to: "home#index"
end
