# frozen_string_literal: true

module Infra
  module Messaging
    module Testing

      RSpec::Matchers.define :have_published do |expected_message|
        match do |publisher|
          raise StandardError, 'must assert against Publisher instance' unless publisher.is_a? Publisher
          raise StandardError, 'publisher strategy must be set to :fake' if Config.publisher_strategy.to_sym != :fake

          PublisherStrategies::Fake.instance.published_messages.any? do |message|
            message.instance_of?(expected_message)
          end
        end

        failure_message do |actual_workflow_instance|
          published_messages = PublisherStrategies::Fake.instance.published_messages.map(&:class)
          "Expected to publish #{expected_message}, but instead published: #{published_messages}"
        end
      end

      def self.clear_published_messages
        raise StandardError, 'publisher strategy must be set to :fake' if Config.publisher_strategy.to_sym != :fake

        PublisherStrategies::Fake.instance.reset
      end

    end
  end
end
