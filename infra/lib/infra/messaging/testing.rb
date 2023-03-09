# frozen_string_literal: true

module Infra
  module Messaging
    module Testing

      RSpec::Matchers.define :have_published do |expected_event|
        match do |publisher|
          raise StandardError, 'must assert against Publisher instance' unless publisher.is_a? Publisher
          raise StandardError, 'publisher strategy must be set to :fake' if Config.publisher_strategy.to_sym != :fake

          PublisherStrategies::Fake.instance.published_messages.any? do |message|
            message.instance_of?(expected_event)
          end
        end

        failure_message do |actual_workflow_instance|
          published_messages = PublisherStrategies::Fake.instance.published_messages.map(&:class)
          "Expected to publish #{expected_event}, but instead published: #{published_messages}"
        end
      end

      def self.clear_published_messages
        raise StandardError, 'publisher strategy must be set to :fake' if Config.publisher_strategy.to_sym != :fake

        PublisherStrategies::Fake.instance.reset
      end

    end
  end
end
