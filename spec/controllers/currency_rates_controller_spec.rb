require 'rails_helper'
RSpec.describe CurrencyRatesController, type: :controller do
  let(:valid_attributes) {
    { rate: 60, force_until: Time.now + 1.days, is_force: true }
  }

  let(:invalid_attributes) {
    { rate: 60, force_until: 1.days.ago, is_force: true }
  }

  describe 'GET #index' do
    it 'returns a success response' do
      currency_rate = CurrencyRate.create valid_attributes
      get :index, params: {}
      expect(response).to render_template(:index)
      expect(assigns(:usd_rate)).to eq(currency_rate.formated_rate)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'create row if force currency rate not exist' do
        expect {
          post :create, params: { currency_rate: valid_attributes }
        }.to change { CurrencyRate.count }.by(1)
                 .and change { ActiveJob::Base.queue_adapter.enqueued_jobs.count }.by(1)
      end

      it 'dont create row if force currency rate exist' do
        CurrencyRate.create!(valid_attributes)
        expect {
          post :create, params: { currency_rate: valid_attributes }
        }.to_not change(CurrencyRate, :count)
      end

      it 'redirects to the created currency_rate' do
        post :create, params: { currency_rate: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the new template)' do
        post :create, params: { currency_rate: invalid_attributes }
        expect(response).to render_template :new
      end
    end
  end
end
