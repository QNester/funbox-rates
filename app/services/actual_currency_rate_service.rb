require 'open-uri'
# Service for manipulation with actual currency rate data
class ActualCurrencyRateService
  URL_FOR_UPDATE = 'https://query.yahooapis.com/v1/public/yql?q=select+*+from+yahoo.finance.xchange+' \
      'where+pair+=+%22USDRUB%22&format=json&env=store%3A%2F%2Fdatatables.org' \
      '%2Falltableswithkeys&callback='.freeze
  MAX_RETRYING_OPEN = 5

  # Get current USD to RUB rate from yahoo API
  #
  # @return [Hash] - rate
  def actual_rate
    retrying_num = 0
    begin
      logger.info('Try to get rate JSON')
      json = JSON.parse(open(URL_FOR_UPDATE).read)
      logger.info('JSON was get successful')
      json['query']['results']
    rescue StandardError
      retrying_num += 1
      logger.info("JSON was not download, retry #{retrying_num}")
      if retrying_num >= MAX_RETRYING_OPEN
        return {'rate': { 'Rate': CurrencyRate.current_online_rate } }
      end
      retry
    end
  end

  # Update current rate with is_force == false
  #
  # @return [Float] - actual USD to RUB rate
  def update_currency_rate
    rate_info = actual_rate
    rate = rate_info['rate']['Rate']
    CurrencyRate.current_online_rate.update(rate: rate)
    rate.to_f.round(2)
  end

  private

  def logger
    Rails.logger
  end
end