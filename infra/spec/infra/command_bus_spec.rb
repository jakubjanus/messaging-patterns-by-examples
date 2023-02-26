# frozen_string_literal: true

RSpec.describe Infra::CommandBus do
  subject(:command_bus) { described_class.new }
  let(:command_a_class) { Class.new(Infra::Command) }
  let(:command_b_class) { Class.new(Infra::Command) }
  let(:handler_a) { Proc.new {} }

  before do
    command_bus.register(command_a_class, handler_a)
  end

  it 'calls registered handler' do
    command = command_a_class.new
    expect(handler_a).to receive(:call).with(command)

    command_bus.call(command)
  end

  context 'when there is no handler registered' do
    it 'raises NoHandlerRegistered error' do
      expect { command_bus.call(command_b_class.new) }.to raise_error(Infra::CommandBus::NoHandlerRegistered)
    end
  end

  context 'when handler has other than call method' do
    let(:handler_b) { Class.new { def start(_command); end }.new }

    before do
      command_bus.register(command_b_class, handler_b, :start)
    end

    it 'calls registered method on handler' do
      command = command_b_class.new
      expect(handler_b).to receive(:start).with(command)

      command_bus.call(command)
    end
  end
end
