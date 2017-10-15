# Job push to websocker subscribers actual rate
class PushActualRateJob < ApplicationJob
  queue_as :default

  def perform
    rate = CurrencyRate.current_rate.formated_rate
    ActionCable.server.broadcast 'actual_rate', rate: rate, from: 'Sidekiq'
  end
end
