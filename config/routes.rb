Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :items

      get '/merchants/:id/items', to: 'merchants/items#index'
      get '/items/:id/merchant', to: 'items/merchants#index'
    end
  end
end
