Rails.application.routes.draw do
  resources :currency_rates, only: :create

  root to: 'currency_rates#index'
  get '/admin', to: 'currency_rates#new'

  put '/currency_rates/updates', to: 'currency_rates#get_updates'
end
