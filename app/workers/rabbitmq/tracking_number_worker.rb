class Rabbitmq::TrackingNumberWorker
  include Sneakers::Worker
  from_queue ENV['RABBITMQ_WORKER_QUEUE'], env: nil

  def work(raw_shipment)
    json_shipment = JSON.parse(raw_shipment)
    Sidekiq::RequestTrakingStatusWorker.perform_async(json_shipment['carrier'], json_shipment['tracking_number']) if json_shipment.has_key?('carrier')
    ack!
  end
end