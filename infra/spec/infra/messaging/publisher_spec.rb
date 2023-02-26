# frozen_string_literal: true

RSpec.describe Infra::Messaging::Publisher do
  subject(:publisher) { described_class.new }

  let(:karafka_producer) { instance_double(WaterDrop::Producer) }

  before do
    allow(Karafka).to receive(:producer).and_return(karafka_producer)
    allow(karafka_producer).to receive(:produce_sync)
  end

  describe 'publishing events' do
    let(:event_class) do
      Class.new(Infra::Messaging::Event) do
        topic 'test-topic'
        event_name 'test_event'

        attribute :value, Infra::Messaging::Types::Integer
        attribute :description, Infra::Messaging::Types::String
      end
    end
    let(:event) { event_class.new(value: 23, description: 'something extra') }

    it 'publishes the event to specified topic' do
      expect(karafka_producer).to receive(:produce_sync) do |topic:, **_rest|
        expect(topic).to eq('test-topic')
      end

      publisher.publish(event)
    end

    it 'adds event name in the headers' do
      expect(karafka_producer).to receive(:produce_sync) do |headers:, **_rest|
        expect(headers).to include('event_name' => 'test_event')
      end

      publisher.publish(event)
    end

    it 'composes payload json from attributes' do
      expect(karafka_producer).to receive(:produce_sync) do |payload:, **_rest|
        expect(payload).to eq('{"value":23,"description":"something extra"}')
      end

      publisher.publish(event)
    end
  end
end
