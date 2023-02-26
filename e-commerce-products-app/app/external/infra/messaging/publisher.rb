# frozen_string_literal: true

module Infra
  module Messaging
    class Publisher
      def publish(messages)
        messages = [messages] unless messages.is_a?(Array)

        messages.each do |message|
          Karafka.producer.produce_sync(topic: message.topic, payload: message.to_json, headers: message.headers)
        end
      end
    end
  end
end
