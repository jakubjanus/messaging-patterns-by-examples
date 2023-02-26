# frozen_string_literal: true

Rails.configuration.to_prepare do
  Rails.configuration.products_service = Services::Products.new(Rails.configuration.messages_publisher)
end
