# frozen_string_literal: true

module Infra
  class CommandBus
    class NoHandlerRegistered < StandardError; end

    def initialize
      @handlers = {}
    end

    def register(command_class, handler, method = :call)
      @handlers[command_class] = [handler, method]
    end

    def call(command)
      handler, method = @handlers[command.class]

      raise NoHandlerRegistered, "No handler for #{command.class}" unless handler

      handler.public_send(method, command)
    end
  end
end
