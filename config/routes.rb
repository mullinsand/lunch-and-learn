Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :recipes, only: [:index]
      resource :learning_resources, only: [:show]
      resources :users, only: %i[create]
      resource :user, only: %i[create], to: 'users#show'
      resource :favorites, only: %i[create destroy]
      resources :favorites, only: [:index]
      resources :tourist_sights, only: [:index]
    end
  end
end
