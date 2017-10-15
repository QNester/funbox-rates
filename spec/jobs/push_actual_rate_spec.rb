require 'rails_helper'

RSpec.describe PushActualRateJob, type: :job do
  before(:all) do
    ActiveJob::Base.queue_adapter = :test
  end

  it 'broadcast actual rate' do
    @rate = create(:currency_rate, is_force: true, force_until: Time.now + 1.days)
    expect {
      PushActualRateJob.set(wait_until: @rate.force_until).perform_later(@rate.id)
    }.to have_enqueued_job.at(@rate.force_until)
  end
end
