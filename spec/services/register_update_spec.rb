require 'rails_helper'
require 'openregister'

RSpec.describe RegisterUpdate do

  let(:id) { double }
  let(:params) { double }

  it 'updates found register with params' do
    register = double
    expect(Register).to receive(:find).with(id).and_return register
    expect(register).to receive(:update_attributes).with(params).and_return true
    expect(described_class.new(id, params).call).to eq register
  end

  it 'returns nil if no register found' do
    expect(Register).to receive(:find).with(id).and_raise Mongoid::Errors::DocumentNotFound.new(Register, id: id)
    expect(described_class.new(id, params).call).to eq nil
  end
end
