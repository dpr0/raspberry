Rails.application.routes.draw do
  resources :sensors
  root to: 'sensors#index'
end
