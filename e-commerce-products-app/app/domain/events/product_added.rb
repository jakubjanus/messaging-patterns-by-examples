# frozen_string_literal: true

module Events
  class ProductAdded < Infra::Messaging::Event
    topic 'products'
    event_name 'product_added'

    attribute :product_number, Infra::Messaging::Types::String
    attribute :name, Infra::Messaging::Types::String
    attribute :description, Infra::Messaging::Types::String.optional
  end
end
