class Sidekiq::RequestTrakingStatusWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  def perform(carrier, tracking_number)
    begin
      tracking_info = ::Carrier::TrackingInfoFactory.create(carrier, tracking_number)
    rescue => err
      raise err
    ensure
    end
  end
end

