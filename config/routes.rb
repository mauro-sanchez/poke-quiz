Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :users, only: %i[new create]
  resources :sessions, only: %i[new create destroy]
  resources :quizzes, only: %i[new create index show] do
    get :quiz_result
  end

  namespace :api do
    namespace :v1 do
      resources :quizzes, only: :index, defaults: { format: :json }
    end
  end

  root 'home#index'
end
