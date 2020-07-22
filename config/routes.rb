Rails.application.routes.draw do
  resources :quotes, only: [:random] do
    collection do
      get :random
    end
  end

  root to: 'quotes#random'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
