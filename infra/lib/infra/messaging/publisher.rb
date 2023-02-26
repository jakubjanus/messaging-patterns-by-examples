# frozen_string_literal: true

require 'karafka'

module Infra
  module Messaging
    class Publisher
      def publish(messages)
        messages = [messages] unless messages.is_a?(Array)

        messages.each do |message|
          Karafka.producer.produce_sync(topic: message.topic, payload: message.payload.to_json, headers: message.headers)
        end
      end
    end
  end
end
