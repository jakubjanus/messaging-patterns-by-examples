# frozen_string_literal: true

module Infra
  module Messaging
    class Message < Dry::Struct
      class << self
        attr_accessor :topic_name

        def topic(topic_name)
          self.topic_name = topic_name
        end
      end

      def topic
        self.class.topic_name
      end

      def headers
        {}
      end
    end
  end
end
