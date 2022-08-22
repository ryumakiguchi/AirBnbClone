Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :flats, only: %i[new create index] do
    resources :reservations, only: %i[new create]
  end
  resources :reservations, only: %i[edit update destroy index]
end
