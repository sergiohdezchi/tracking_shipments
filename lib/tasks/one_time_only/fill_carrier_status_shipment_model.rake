##############################################
#   rake one_time_only:fill_carrier_status_shipment_model   #
##############################################

namespace :one_time_only do
  desc 'Fill carrier_status_shipment model'

  STATUS_SHIPMENTS = %i[CREATED ON_TRANSIT DELIVERED EXCEPTION]
  CARRIER_NAME = 'fedex'
  FEDEX_CODE_RELATION = {
    CREATED: %i[AF AP OC],
    ON_TRANSIT: %i[AA AD CH DP DR DS EA ED EO EP EO EP FD IT LO PF PL PU],
    DELIVERED: %i[DL],
    EXCEPTION: %i[CA DE DY HL OD RS SE SF SP TR]
  }

  task fill_carrier_status_shipment_model: :environment do
    puts "========== Task begins at #{Time.current} =========="

    carrier = Carrier.find_or_create_by(name: CARRIER_NAME)

    STATUS_SHIPMENTS.each do |status|
      StatusShipment.find_or_create_by(status: status)
    end

    FEDEX_CODE_RELATION.each do |key, value|
      status_shipment = StatusShipment.find_by(status: key)

      value.each do |status|
        CarrierStatusShipment.find_or_create_by(status: status, carrier: carrier, status_shipment: status_shipment)
      end
    end


    puts "============ Task ends at #{Time.current} ==========="
  end
end