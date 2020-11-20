# README

* Run rake task for rabbitmq setup

  rake rabbitmq:setup
   
* Run for migrate tables

  rake db:migrate

* Run rake task for fill Fedex Status Tables

  rake one_time_only:fill_carrier_status_shipment_model

* Run for sidekiq works

  redis-server --daemonize yes
  
  bundle exec sidekiq -C config/sidekiq.yml

* Run rabbitmq worker

  WORKERS=Rabbitmq::TrackingNumberWorker rake sneakers:run
