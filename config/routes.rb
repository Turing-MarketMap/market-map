Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/listings/search', to: 'listings#search'
      resources :listings
      # may need to update these routes to utilize sessions properly
      resources :users, only: [:create, :destroy] do
        # resources :listings, only: :index
        get '/listings', to: 'users/listings#index'
      end
    end
  end
end
