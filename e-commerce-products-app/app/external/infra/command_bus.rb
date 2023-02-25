# frozen_string_literal: true

module Infra
  class CommandBus
    class NoHandlerRegistered < StandardError; end

    def initialize
      @handlers = {}
    end

    def register(command_class, handler)
      @handlers[command_class] = handler
    end

    def call(command)
      handler = @handlers[command.class]

      raise NoHandlerRegistered, "No handler for #{command.class}" unless handler

      handler.call(command)
    end
  end
end
