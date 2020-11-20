class AddStatusShipmentToCarrierStatusShipment < ActiveRecord::Migration[5.1]
  def change
    add_column :carrier_status_shipments, :status_shipment_id, :integer
    add_index :carrier_status_shipments, :status_shipment_id
  end
end
