Rails.application.routes.draw do
  devise_for :users
  root to: 'restaurants#index'
  resources :restaurants do
    resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
        resources :restaurants, only: [ :index, :show, :update, :create, :destroy ]

    end
  end
end
