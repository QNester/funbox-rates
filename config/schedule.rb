set :output, 'log/whenever.log'

every 1.minutes do
  runner 'ActualCurrencyRateService.new.update_currency_rate'
end