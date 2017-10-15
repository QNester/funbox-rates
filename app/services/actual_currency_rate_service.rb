require 'open-uri'
# Service for manipulation with actual currency rate data
class ActualCurrencyRateService
  URL_FOR_UPDATE = 'http://api.fixer.io/latest?base=USD'.freeze
  MAX_RETRYING_OPEN = 5
  TIMEOUT_SEC = 10

  # Get current USD to RUB rate from yahoo API
  #
  # @return [Float] - USD to RUB rate
  def actual_rate
    retrying_num = 0
    begin
      logger.info('Try to get rate JSON')
      json = JSON.parse(open(URL_FOR_UPDATE, read_timeout: TIMEOUT_SEC).read)
      logger.info('JSON was get successful')
      json['rates']['RUB']
    rescue StandardError
      retrying_num += 1
      logger.info("JSON was not download, retry #{retrying_num}")
      if retrying_num >= MAX_RETRYING_OPEN
        return CurrencyRate.current_online_rate.rate
      end
      retry
    end
  end

  # Update current rate with is_force == false
  # If current_rate nil create rate with default params
  # This method push rate to websockets.
  #
  # @return [CurrencyRate] - actual USD to RUB rate
  def update_currency_rate
    current_rate = CurrencyRate.current_rate ||
        CurrencyRate.create(rate: 57.00, is_force: false)
    return if current_rate.force?
    current_rate.update!(rate: actual_rate.to_f)
    ActionCable.server.broadcast 'actual_rate', rate: current_rate.rate, from: 'Update currency in service'
    current_rate
  end

  private

  def logger
    Rails.logger
  end
end