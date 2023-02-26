# frozen_string_literal: true

require_relative 'message'

module Infra
  module Messaging
    class Event < Message
      class << self
        attr_accessor :event_name_value

        def event_name(event_name)
          self.event_name_value = event_name
        end
      end

      def event_name
        self.class.event_name_value
      end

      def headers
        super.merge({ 'event_name' => event_name })
      end
    end
  end
end
