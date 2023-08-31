Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :markets, only: [:index, :show] do
        resources :vendors, only: :index, to: 'market_vendors#index'
      end
      resources :vendors, only: [:show, :new, :create, :update, :destroy]
      resources :market_vendors, only: [:new, :create]
    end
  end
end
