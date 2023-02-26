# frozen_string_literal: true

require 'securerandom'

module Services
  class Products
    def initialize(events_publisher)
      @events_publisher = events_publisher
    end

    def add_product(command)
      product = Product.create!(
        name: command.name,
        description: command.description,
        category: command.category,
        product_number: generate_product_number
      )

      publish_product_added(product)

      product.product_number
    end

    private

    attr_reader :events_publisher

    def generate_product_number
      SecureRandom.alphanumeric(8)
    end

    def publish_product_added(product)
      event = Events::ProductAdded.new(
        product_number: product.product_number,
        name: product.name,
        description: product.description
      )

      events_publisher.publish(event)
    end
  end
end
