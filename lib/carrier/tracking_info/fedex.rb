require 'fedex'

class Carrier::TrackingInfo::Fedex

  def initialize(tracking_number)
    @tracking_number = tracking_number
    @connection = client.connection
  end

  def status_code
    raise ArgumentError.new("Tracking_number canot be nil") if @tracking_number.nil?

    tracking_info.try(:status_code)
  end

  def tracking_info
    begin
      @connection.track(:tracking_number => @tracking_number).first
    rescue Fedex::RateError => error
      Rails.logger.info("Tracking number not found: #{error}")
    end
  end

  private

  def client
    @client ||= ::Fedex::Client.new
  end
end
