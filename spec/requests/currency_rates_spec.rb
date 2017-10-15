require 'rails_helper'

RSpec.describe 'CurrencyRates', type: :request do
  describe 'GET /' do
    it 'success response html' do
      get '/'
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it 'success response json' do
      get '/rate.json'
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /admin' do
    it 'success response html' do
      get '/admin'
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end

    it 'success response json' do
      get '/admin.json'
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /currency_rates' do
    it 'success response html' do
      params = {
          currency_rate: {
              rate: 300,
              force_until: Time.now + 1.days
          }
      }
      post '/currency_rates', params: params
      expect(response).to redirect_to root_path
    end

    it 'success response json' do
      params = {
          currency_rate: { rate: 300, force_until: Time.now + 1.days }
      }
      post '/currency_rates.json', params: params
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it 'unpocessable response html' do
      params = {}
      post '/currency_rates', params: params
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end

    it 'unprocessable response json' do
      params = {}
      post '/currency_rates.json', params: params
      expect(response).to have_http_status(422)
    end
  end
end
