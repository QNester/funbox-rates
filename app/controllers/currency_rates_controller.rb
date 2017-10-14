class CurrencyRatesController < ApplicationController
  # GET /currency_rates
  # GET /currency_rates.json
  def index
    rate = CurrencyRate.current_force_rate ||
                actual_rate_service.update_currency_rate
    @usd_rate = rate.rate

    respond_to do |format|
      format.html
      format.json { render json: { rate: @usd_rate } }
    end
  end

  def new
    @currency_rate = CurrencyRate.new
  end

  # POST /currency_rates
  # POST /currency_rates.json
  def create
    @currency_rate = CurrencyRate.new(currency_rate_params)
    @currency_rate.is_force = true
    respond_to do |format|
      if @currency_rate.save
        RemoveExpiredRateJob.set(wait_until: @currency_rate.force_until).perform_later(@currency_rate.id)
        ActionCable.server.broadcast 'actual_rate', rate: CurrencyRate.current_rate.rate, from: 'Create force rate'
        format.html { redirect_to '/', notice: 'Currency rate was successfully created.' }
        format.json { render :show, status: :created, location: @currency_rate }
      else
        format.html { render :new }
        format.json { render json: @currency_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def currency_rate_params
    params.fetch(:currency_rate, {}).permit(:rate, :force_until)
  end

  def actual_rate_service
    @actual_rate_service ||= ActualCurrencyRateService.new
  end
end
