Rails.application.routes.draw do
  resources :sensors, only: [:index, :create, :update, :destroy, :edit] do
    post :check, on: :collection
    post :set, on: :collection
  end
  root to: 'sensors#index'
end
