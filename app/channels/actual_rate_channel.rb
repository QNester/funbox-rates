class ActualRateChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'actual_rate'
  end
end
