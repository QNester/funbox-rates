# Job remove expired force rate from table and
# push to websocker actual current rate
class PushActualRateJob < ApplicationJob
  queue_as :default

  def perform(rate_id)
    rate = CurrencyRate.current_rate.formated_rate
    ActionCable.server.broadcast 'actual_rate', rate: rate, from: 'Sidekiq'
  end
end
