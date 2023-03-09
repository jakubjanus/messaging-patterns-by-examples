# frozen_string_literal: true

require 'singleton'

module Infra
  module Messaging
    module PublisherStrategies
      class Fake

        include Singleton

        def initialize
          reset
        end

        def publish(message)
          @messages.push(message)
        end

        def reset
          @messages = []
        end
      end
    end
  end
end
