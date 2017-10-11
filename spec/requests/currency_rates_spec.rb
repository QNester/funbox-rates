require 'rails_helper'

RSpec.describe "CurrencyRates", type: :request do
  describe "GET /currency_rates" do
    it "works! (now write some real specs)" do
      get currency_rates_path
      expect(response).to have_http_status(200)
    end
  end
end
