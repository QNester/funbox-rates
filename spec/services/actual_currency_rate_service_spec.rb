require 'rails_helper'

RSpec.describe ActualCurrencyRateService do

  JSON_RATE = 299.00

  before(:each) do
    CurrencyRate.destroy_all
    WebMock.disable_net_connect!
  end

  after(:all) do
    WebMock.allow_net_connect!
  end

  context '#actual_rate' do

    it 'should return rate' do
      success_stub

      expect(service.actual_rate).to eq(JSON_RATE)
    end

    it 'should return rate from db if api error' do
      @rate = create(:currency_rate)
      error_stub

      expect(service.actual_rate).to eq(@rate.rate)
    end
  end

  context '#update_currency_rate' do

    it 'should update current unforce rate' do
      @rate = create(:currency_rate)
      success_stub

      service.update_currency_rate
      expect(CurrencyRate.current_online_rate.rate).to eq(JSON_RATE)
    end

    it 'should create unforced rate if not exist' do
      success_stub

      expect {
        service.update_currency_rate
      }.to change(CurrencyRate, :count).by(1)
    end
  end

  private

  def success_stub
    json_rates_stub = '{"rates":{"RUB":' + JSON_RATE.to_s + '}}'
    stub_request(:get, ActualCurrencyRateService::URL_FOR_UPDATE)
        .to_return(body: json_rates_stub.to_s)
  end

  def error_stub
    stub_request(:get, ActualCurrencyRateService::URL_FOR_UPDATE)
        .to_return(body: 'ERROR')
  end

  def service
    @service ||= ActualCurrencyRateService.new
  end
end

