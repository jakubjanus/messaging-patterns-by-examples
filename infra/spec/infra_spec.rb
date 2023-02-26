# frozen_string_literal: true

RSpec.describe Infra do
  it "has a version number" do
    expect(Infra::VERSION).not_to be nil
  end
end
