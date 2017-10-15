Rails.application.routes.draw do
  resources :currency_rates, only: :create

  root to: 'currency_rates#index'
  get '/rate(.:format)', to: 'currency_rates#index'
  get '/admin(.:format)', to: 'currency_rates#new'

  # require 'sidekiq/web'
  # mount Sidekiq::Web => '/sidekiq'
end
