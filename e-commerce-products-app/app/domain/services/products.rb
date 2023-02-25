# frozen_string_literal: true

require 'securerandom'

module Services
  class Products
    def add_product(command)
      Product.create!(
        name: command.name,
        description: command.description,
        category: command.category,
        product_number: generate_product_number
      )
    end

    private

    def generate_product_number
      SecureRandom.alphanumeric(8)
    end
  end
end
