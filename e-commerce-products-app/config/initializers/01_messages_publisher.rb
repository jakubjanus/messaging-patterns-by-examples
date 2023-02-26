# frozen_string_literal: true

Rails.configuration.to_prepare do
  Rails.configuration.messages_publisher = Infra::Messaging::Publisher.new
end
