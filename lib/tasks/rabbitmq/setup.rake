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
    ch.fanout(ENV['RABBITMQ_WORKER_EVENT'])
    queue = ch.queue(ENV['RABBITMQ_WORKER_QUEUE'], durable: true)
    queue.bind(ENV['RABBITMQ_WORKER_EVENT'])

    ch.fanout(ENV['RABIITMQ_PUBLISHER_EVENT'])
    queue2 = ch.queue(ENV['RABBITMQ_PUBLISHER_QUEUE'], durable: true)
    queue2.bind(ENV['RABIITMQ_PUBLISHER_EVENT'])

    conn.close
  end
end