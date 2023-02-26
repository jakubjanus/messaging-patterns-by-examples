# frozen_string_literal: true

module Events
  class ProductAdded < Infra::Messaging::Event
    topic 'products'
    event_name 'product_added'

    attribute :product_number, Infra::Command::Types::String
    attribute :name, Infra::Command::Types::String
    attribute :description, Infra::Command::Types::String.optional
  end
end
