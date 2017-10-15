# Decorator for save force rate
class RateSaver
  attr_reader :object

  # @param rate_params [Hash] - params for create/update force rate
  def initialize(rate_params)
    @params = rate_params
    @object = CurrencyRate.current_force_rate || CurrencyRate.new(rate_params)
    @object.is_force = true
  end

  # Create or update force rate
  # Push forced rate to websocket
  # Set job for update websocket subscribers when rate will expired
  def save
    return @object.save && create_job_and_broadcast if @object.new_record?
    @object.update(@params) && create_job_and_broadcast
  end

  private

  def create_job_and_broadcast
    PushActualRateJob.set(wait_until: @object.force_until).perform_later
    ActionCable.server.broadcast(
        'actual_rate',
        rate: CurrencyRate.current_rate.formated_rate,
        from: 'Create force rate'
    )
    true
  end
end