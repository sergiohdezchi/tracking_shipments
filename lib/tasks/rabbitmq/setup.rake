# frozen_string_literal: true
# rake rabbitmq:setup
require 'sneakers/tasks'

namespace :rabbitmq do
  desc 'Setup routing'

  task :setup do
    require "bunny"

    conn = Bunny.new(
      host: ENV['RABBITMQ_HOST'],
      port: ENV['RABBITMQ_PORT'],
      user: ENV['RABBITMQ_USER'],
      password: ENV['RABBITMQ_PASSWORD']
    )
    conn.start

    ch = conn.create_channel
    ch.fanout('shipment_events')
    queue = ch.queue('shipment_tracking_queue', durable: true)
    queue.bind('shipment_events')

    conn.close
  end
end