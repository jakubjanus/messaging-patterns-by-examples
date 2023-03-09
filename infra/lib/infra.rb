# frozen_string_literal: true

require_relative 'infra/command'
require_relative 'infra/command_bus'
require_relative 'infra/config'
require_relative 'infra/messaging'
require_relative 'infra/version'

module Infra
  class Error < StandardError; end
end
