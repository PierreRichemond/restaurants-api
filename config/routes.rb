Rails.application.routes.draw do
  devise_for :users
  root to: 'restaurants#index'

  resources :users do
      resources :restaurants, except: [:index] do
          resources :comments
      end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
        resources :restaurants, only: [ :index, :show, :update, :create, :destroy ]

    end
  end
end
