# frozen_string_literal: true

require 'karafka'

module Infra
  module Messaging
    class Publisher
      def initialize
        @strategy = Config.publisher_strategy
      end

      def publish(messages)
        messages = [messages] unless messages.is_a?(Array)

        messages.each do |message|
          strategy.publish(message)
        end
      end

      private

      attr_reader :strategy
    end
  end
end
