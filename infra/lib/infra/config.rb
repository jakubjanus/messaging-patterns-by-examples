# frozen_string_literal: true

require_relative 'messaging/publisher_strategies/karafka_sync'
require_relative 'messaging/publisher_strategies/fake'

module Infra
  class Config
    class ConfigurationError < StandardError; end

    class << self
      STRATEGIES = [:kafka_sync, :fake]

      def publisher_strategy=(strategy_sym)
        case strategy_sym
        when :kafka_sync
          @publisher_strategy = Messaging::PublisherStrategies::KarafkaSync.new
        when :fake
          @publisher_strategy = Messaging::PublisherStrategies::Fake.instance
        else
          raise ConfigurationError, "Not allowed pubblisher strategy #{strategy_sym}"
        end
      end

      def publisher_strategy
        @publisher_strategy ||= Messaging::PublisherStrategies::KarafkaSync.new
      end
    end
  end
end
