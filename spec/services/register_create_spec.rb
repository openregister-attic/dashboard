require 'rails_helper'
require 'openregister'

RSpec.describe RegisterCreate do

  let(:params) { double }

  it 'creates new Register from params' do
    register = double
    expect(Register).to receive(:new).with(params).and_return register
    expect(described_class.new(params).call).to eq register
  end
end
