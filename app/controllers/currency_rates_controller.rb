class CurrencyRatesController < ApplicationController
  # GET /currency_rates
  # GET /currency_rates.json
  def index
    rate = CurrencyRate.current_force_rate ||
                actual_rate_service.update_currency_rate
    @usd_rate = rate.formated_rate

    respond_to do |format|
      format.html
      format.json
    end
  end

  # GET /admin
  # GET /admin.json
  def new
    @currency_rate = CurrencyRate.new
    @last_rate = CurrencyRate.where(is_force: true).last
    respond_to do |format|
      format.html
      format.json
    end
  end

  # POST /currency_rates
  # POST /currency_rates.json
  def create
    @currency_rate = RateSaver.new(currency_rate_params)
    respond_to do |format|
      if @currency_rate.save
        format.html { redirect_to '/', notice: 'Currency rate was successfully created.' }
        @usd_rate = @currency_rate.object.formated_rate
        format.json { render :index }
      else
        @currency_rate = @currency_rate.object
        format.html { render :new }
        format.json { render json: @currency_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def currency_rate_params
    params.fetch(:currency_rate, {}).permit(:rate, :force_until)
  end

  def actual_rate_service
    @actual_rate_service ||= ActualCurrencyRateService.new
  end
end
