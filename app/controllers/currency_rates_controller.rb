class CurrencyRatesController < ApplicationController
  before_action :set_currency_rate, only: [:show, :edit, :update, :destroy]

  # GET /currency_rates
  # GET /currency_rates.json
  def index
    @usd_rate = CurrencyRate.current_force_rate ||
                actual_rate_service.update_currency_rate
    respond_to do |format|
      format.html
      format.json { render json: { rate: @usd_rate } }
    end
  end

  # POST /currency_rates
  # POST /currency_rates.json
  def create
    @currency_rate = CurrencyRate.new(currency_rate_params)
    @currency_rate.is_force = true
    respond_to do |format|
      if @currency_rate.save
        format.html { redirect_to @currency_rate, notice: 'Currency rate was successfully created.' }
        format.json { render :show, status: :created, location: @currency_rate }
      else
        format.html { render :new }
        format.json { render json: @currency_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /currency_rates/updates
  def get_updates
    rate = ActualCurrencyRateService.new.update_currency_rate
    render json: { rate: rate }
  end

  # PATCH/PUT /currency_rates/1
  # PATCH/PUT /currency_rates/1.json
  def update
    respond_to do |format|
      if @currency_rate.update(currency_rate_params)
        format.html { redirect_to @currency_rate, notice: 'Currency rate was successfully updated.' }
        format.json { render :show, status: :ok, location: @currency_rate }
      else
        format.html { render :edit }
        format.json { render json: @currency_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /currency_rates/1
  # DELETE /currency_rates/1.json
  def destroy
    @currency_rate.destroy
    respond_to do |format|
      format.html { redirect_to currency_rates_url, notice: 'Currency rate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_currency_rate
    @currency_rate = CurrencyRate.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def currency_rate_params
    params.fetch(:currency_rate, {}).permit(:rate, :force_until)
  end

  def actual_rate_service
    @actual_rate_service ||= ActualCurrencyRateService.new
  end
end
