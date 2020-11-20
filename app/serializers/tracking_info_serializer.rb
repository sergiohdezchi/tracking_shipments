class TrackingInfoSerializer < ActiveModel::Serializer

  attributes :tracking_number, :carrier, :status_code
end