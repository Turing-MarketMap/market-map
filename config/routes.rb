Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/listings/search', to: 'listings#search'
      get '/fair_price', to: 'fair_price#predict'
      resources :listings, only: [:index, :show, :create, :update]
      # may need to update these routes to utilize sessions properly
      resources :users, only: [:create, :destroy] do
        scope module: :users do
          resources :listings, only: [:index, :create, :destroy]
        end
      end
    end
  end
end
