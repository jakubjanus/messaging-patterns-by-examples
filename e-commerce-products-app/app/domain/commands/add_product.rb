# frozen_string_literal: true

module Commands
  class AddProduct < Infra::Command
    attribute :name, Infra::Command::Types::String
    attribute :description, Infra::Command::Types::String.optional
    attribute :category, Infra::Command::Types::String.optional
  end
end
