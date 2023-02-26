# frozen_string_literal: true

Rails.configuration.to_prepare do
  Rails.configuration.command_bus = Infra::CommandBus.new

  Rails.configuration.command_bus.register(
    Commands::AddProduct,
    Rails.configuration.products_service,
    :add_product
  )
end
