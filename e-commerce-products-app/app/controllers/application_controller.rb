class ApplicationController < ActionController::API
  def command_bus
    Rails.configuration.command_bus
  end
end

