class AddCarrierToCarrierStatusShipment < ActiveRecord::Migration[5.1]
  def change
    add_column :carrier_status_shipments, :carrier_id, :integer
    add_index :carrier_status_shipments, :carrier_id
  end
end
