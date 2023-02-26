# frozen_string_literal: true

module Api
  class ProductsController < ApplicationController
    def index
      products = Product.all.map(&:as_json)

      render json: { products: products }
    end

    def create
      command = Commands::AddProduct.new(
        name: product_params['name'],
        description: product_params['description'],
        category: product_params['category']
      )

      result = command_bus.call(command)

      render json: { product_number: result }
    end

    private

    def product_params
      params[:product].as_json
    end
  end
end
