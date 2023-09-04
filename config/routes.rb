Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get 'markets/search', to: 'markets_search#index'
      
      resources :markets, only: [:index, :show] do
        resources :vendors, only: :index, to: 'market_vendors#index'
      end
      resources :vendors, only: [:show, :new, :create, :update, :destroy]
      resources :market_vendors, only: [:new, :create]
      resource :market_vendors, only: :destroy
    end
  end
end
