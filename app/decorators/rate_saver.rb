class RateSaver
  attr_reader :object

  def initialize(rate)
    @object = rate
    @object.is_force = true
  end

  def save
    @object.save && create_job_and_broadcast
  end

  private

  def create_job_and_broadcast
    RemoveExpiredRateJob.set(wait_until: @object.force_until).perform_later(@object.id)
    ActionCable.server.broadcast 'actual_rate', rate: CurrencyRate.current_rate.formated_rate, from: 'Create force rate'
    true
  end
end