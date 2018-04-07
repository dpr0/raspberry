Rails.application.routes.draw do
  resources :sensors, only: :index
  root to: 'sensors#index'
end
