Rails.application.routes.draw do
  resources :sensors, only: :index do
    post :set_gpio, on: :collection
  end
  root to: 'sensors#index'
end
