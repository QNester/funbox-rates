require 'rails_helper'

RSpec.describe CurrencyRatesController, type: :routing do
  describe 'routing' do

    it 'route to root' do
      expect(:get => '/').to route_to('currency_rates#index')
      end

    it 'route to rate' do
      expect(:get => '/rate').to route_to('currency_rates#index')
    end

    it 'route to admin' do
      expect(:get => '/admin').to route_to('currency_rates#new')
    end

    it 'route to create rate' do
      expect(:post => '/currency_rates').to route_to('currency_rates#create')
    end
  end
end
