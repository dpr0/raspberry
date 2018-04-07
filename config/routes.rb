Rails.application.routes.draw do
  resources :sensors, only: [:index, :create]
  root to: 'sensors#index'
end
