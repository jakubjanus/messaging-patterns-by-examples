# frozen_string_literal: true

class KarafkaApp < Karafka::App
  setup do |config|
    kafka_host = ENV.fetch('KAFKA_HOST', '127.0.0.1')
    kafka_port = ENV.fetch('KAFKA_PORT', '9092')
    config.kafka = { 'bootstrap.servers': "#{kafka_host}:#{kafka_port}" }
    config.client_id = 'pricing-app'
    # Recreate consumers with each batch. This will allow Rails code reload to work in the
    # development mode. Otherwise Karafka process would not be aware of code changes
    config.consumer_persistence = !Rails.env.development?
  end

  # Comment out this part if you are not using instrumentation and/or you are not
  # interested in logging events for certain environments. Since instrumentation
  # notifications add extra boilerplate, if you want to achieve max performance,
  # listen to only what you really need for given environment.
  Karafka.monitor.subscribe(Karafka::Instrumentation::LoggerListener.new)
  # Karafka.monitor.subscribe(Karafka::Instrumentation::ProctitleListener.new)

  # This logger prints the producer development info using the Karafka logger.
  # It is similar to the consumer logger listener but producer oriented.
  Karafka.producer.monitor.subscribe(
    WaterDrop::Instrumentation::LoggerListener.new(Karafka.logger)
  )

  routes.draw do
    topic :products do
      consumer ProductsConsumer
    end
  end
end
