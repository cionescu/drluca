Rails.application.routes.draw do

  resources :dict, only: [:index] do
    collection do
      get :search
    end
  end

  root to: "home#index"
end
