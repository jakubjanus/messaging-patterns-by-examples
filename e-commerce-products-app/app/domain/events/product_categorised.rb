# frozen_string_literal: true

module Events
  class ProductCategorised < Infra::Messaging::Event
    topic 'products'
    event_name 'product_categorised'

    attribute :product_number, Infra::Messaging::Types::String
    attribute :category, Infra::Messaging::Types::String
    attribute :category_reference, Infra::Messaging::Types::String
  end
end
