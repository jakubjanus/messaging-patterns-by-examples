# frozen_string_literal: true

require 'rails_helper'
require 'infra/messaging/testing'

RSpec.describe Services::Products do
  subject(:products_service) { described_class.new(events_publisher) }
  let(:events_publisher) { Infra::Messaging::Publisher.new }

  before do
    Infra::Config.publisher_strategy = :fake
    Infra::Messaging::Testing.clear_published_messages
  end

  describe '#add_product' do
    let(:command) do
      Commands::AddProduct.new(name: 'Rondo jersey', description: 'Boston celtics, number 9', category: nil)
    end

    it 'creates new Product record' do
      expect do
        products_service.add_product(command)
      end.to change(Product, :count).by(1)
    end

    it 'returns product number' do
      expect(products_service.add_product(command)).to be_an_instance_of String
    end

    it 'publishes ProductAdded event' do
      products_service.add_product(command)

      expect(events_publisher).to have_published(Events::ProductAdded)
    end

    it 'does not publish ProductCategorised event' do
      products_service.add_product(command)

      expect(events_publisher).not_to have_published(Events::ProductCategorised)
    end

    context 'with specified category' do
      let(:command) do
        Commands::AddProduct.new(name: 'Rondo jersey', description: 'Boston celtics, number 9', category: 'top wear')
      end

      it 'publishes ProductCategorised event' do
        products_service.add_product(command)

        expect(events_publisher).to have_published(Events::ProductCategorised)
      end
    end
  end
end
