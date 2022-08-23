Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :flats do
    resources :reservations, only: %i[new create]
  end
  resources :reservations, except: %i[new create]
  get "/my_flats", to: "flats#my_flats"
  post "/my_flats", to: "flats#confirm"
end
