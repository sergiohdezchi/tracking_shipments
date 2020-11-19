require 'fedex'

class Carrier::TrackingInfo::Fedex

  def initialize(tracking_number)
    @tracking_number = tracking_number
    @key = Rails.application.secrets.fedex[:key]
    @password = Rails.application.secrets.fedex[:password]
    @account_number = Rails.application.secrets.fedex[:account_number]
    @meter = Rails.application.secrets.fedex[:meter]
    @mode = Rails.application.secrets.fedex[:mode]
  end

  def status_code
    tracking_info.try(:status_code)
  end

  def tracking_info
    begin
      connection.track(:tracking_number => @tracking_number).first
    rescue Fedex::RateError => error
      Rails.logger.info("Tracking number not found: #{error}")
    end
  end

  private

  def connection
    ::Fedex::Shipment.new(
      key: @key,
      password: @password,
      account_number: @account_number,
      meter: @meter,
      mode: @mode
    )
  end
end
