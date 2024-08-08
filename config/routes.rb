Rails.application.routes.draw do
  get 'static_pages/top'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  root 'static_pages#top'
  # Defines the root path route ("/")
  # root "posts#index"
  resources :users, only: %i[new create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :questions, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  get 'random_question', to: 'questions#random', as: 'random_question'

  resources :results, only: [] do
    member do
      get 'check'
    end
  end
end
