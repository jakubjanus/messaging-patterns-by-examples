# frozen_string_literal: true

require 'dry-struct'

module Infra
  class Command < Dry::Struct
    module Types
      include Dry.Types()
    end
  end
end
