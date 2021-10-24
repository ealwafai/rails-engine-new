Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show]
      get '/merchants/:id/items', to: 'merchants/items#index'
    end
  end
end
