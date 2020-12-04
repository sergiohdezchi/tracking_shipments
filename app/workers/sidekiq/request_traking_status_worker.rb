class Sidekiq::RequestTrakingStatusWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  def perform(carrier, tracking_number)
    tracking_info = ::Carrier::TrackingInfoFactory.create(carrier, tracking_number)
    status_code = tracking_info.status_code
  rescue ArgumentError => error
    puts "ArgumentError: #{error}"
  rescue => error
    raise error
  else
    publish_status(carrier, tracking_number, status_code)
  end

  private

  def publish_status(carrier, tracking_number, status_code)
    ::Publisher.publish(
      ENV['RABIITMQ_PUBLISHER_EVENT'],
      tracking_info_serializer(carrier, tracking_number, status_code)
    )
  end

  def tracking_info_serializer(carrier, tracking_number, status_code)
    tracking_info = OpenStruct.new(
      {
        tracking_number: tracking_number,
        carrier: carrier,
        status_code: status_code(carrier, status_code)
      }
    ).extend(ActiveModel::Serialization)

    TrackingInfoSerializer.new(
      tracking_info
    ).as_json
  end

  def status_code(carrier, status_code)
    return 'not found' if status_code.nil?

    Carrier.find_by(name: carrier.downcase).carrier_status_shipments.where(status: status_code).first.status_shipment.status
  end
end

