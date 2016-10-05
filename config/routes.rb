Rails.application.routes.draw do
  resource :authentication, only: [:new, :create, :destroy]

  resources :feedbacks, only: [:new, :create]
  resources :incidents, only: :show
  resources :people, only: [:index, :new, :create, :show]
  resources :preferences, only: :create
  resources :suggestions, only: [:new, :create, :show]

  resources :drafts, only: [:index, :show, :create, :edit, :update, :destroy]
  resources :submissions, only: [:index, :show, :create, :destroy] do
    member { patch :approve }
  end

  get "/response_plans", to: redirect("/")
  root to: "people#index"
end
