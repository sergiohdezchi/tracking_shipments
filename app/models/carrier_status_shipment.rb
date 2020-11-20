class CarrierStatusShipment < ApplicationRecord

  belongs_to :carrier
  belongs_to :status_shipment
end
