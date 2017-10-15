class RateSaver
  attr_reader :object

  def initialize(rate_params)
    @params = rate_params
    @object = CurrencyRate.current_force_rate || CurrencyRate.new(rate_params)
    @object.is_force = true
  end

  def save
    return @object.save && create_job_and_broadcast if @object.new_record?
    @object.update(@params) && create_job_and_broadcast
  end

  private

  def create_job_and_broadcast
    RemoveExpiredRateJob.set(wait_until: @object.force_until).perform_later(@object.id)
    ActionCable.server.broadcast 'actual_rate', rate: CurrencyRate.current_rate.formated_rate, from: 'Create force rate'
    true
  end
end