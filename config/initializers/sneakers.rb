Sneakers.configure(
  {
    :amqp => "amqp://#{ENV['RABBITMQ_USER']}:#{ENV['RABBITMQ_PASSWORD']}@#{ENV['RABBITMQ_HOST']}:#{ENV['RABBITMQ_PORT']}"
  }
)

Sneakers.logger.level = Logger::INFO
