# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Products do
  subject(:products_service) { described_class.new }

  describe '#add_product' do
    let(:command) do
      Commands::AddProduct.new(name: 'Rondo jersey', description: 'Boston celtics, number 9', category: nil)
    end

    it 'creates new Product record' do
      expect do
        products_service.add_product(command)
      end.to change(Product, :count).by(1)
    end
  end
end
