# Job remove expired force rate from table and
# push to websocker actual current rate
class RemoveExpiredRateJob < ApplicationJob
  queue_as :default

  def perform(rate_id)
    CurrencyRate.find(rate_id).destroy!
    current_rate = CurrencyRate.current_rate
    ActionCable.server.broadcast 'actual_rate', rate: current_rate.rate, from: 'Sidekiq'
  end
end
