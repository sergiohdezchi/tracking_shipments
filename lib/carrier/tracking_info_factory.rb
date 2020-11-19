class Carrier::TrackingInfoFactory

  CARRIER_NAMES = {
    fedex: ::Carrier::TrackingInfo::Fedex
  }.with_indifferent_access.freeze

  def self.create(carrier, tracking_number)
    return CARRIER_NAMES[carrier.downcase].new(tracking_number) if CARRIER_NAMES.has_key?(carrier.downcase)

    raise ArgumentError.new("Carrier '#{carrier}' not defined.")
  end
end