require 'rails_helper'
require 'openregister'

RSpec.describe RegisterCreate do

  let(:params) { double }

  it 'creates new register from params' do
    register = double
    expect(Register).to receive(:new).with(params).and_return register
    expect(register).to receive(:save).and_return true
    expect(described_class.new(params).call).to eq register
  end
end
