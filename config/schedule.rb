set :output, 'log/whenever.log'
set :environment, 'development'

every 5.minutes do
  runner 'ActualCurrencyRateService.new.update_currency_rate'
end