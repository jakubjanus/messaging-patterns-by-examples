# frozen_string_literal: true

require 'karafka'

module Infra
  module Messaging
    module PublisherStrategies
      class KarafkaSync
        def publish(message)
          Karafka.producer.produce_sync(topic: message.topic, payload: message.payload.to_json,
                                        headers: message.headers)
        end
      end
    end
  end
end
