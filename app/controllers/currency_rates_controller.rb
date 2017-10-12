class CurrencyRatesController < ApplicationController
  # GET /currency_rates
  # GET /currency_rates.json
  def index
    @usd_rate = CurrencyRate.current_force_rate.rate ||
                actual_rate_service.update_currency_rate
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
        format.html { redirect_to '/', notice: 'Currency rate was successfully created.' }
        format.json { render :show, status: :created, location: @currency_rate }
      else
        format.html { render :new }
        format.json { render json: @currency_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /currency_rates/updates
  def get_updates
    rate = actual_rate_service.update_currency_rate
    render json: { rate: rate }
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
