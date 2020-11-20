class CreateStatusShipments < ActiveRecord::Migration[5.1]
  def change
    create_table :status_shipments do |t|
      t.string :status

      t.timestamps
    end
  end
end
