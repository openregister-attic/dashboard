require 'rails_helper'
require 'openregister'

RSpec.describe RegistersByPhase do
  let(:beta_register) { double(register: 'school', phase: 'beta') }
  let(:alpha_register) { double(register: 'address', phase: 'alpha') }

  let(:persisted_register) do
    Register.new(
      register: 'country',
      registry: 'foreign-commonwealth-office',
      text: 'British English-language names and descriptive terms for countries',
      phase: 'beta'
    )
  end

  it 'returns registers from API calls grouped by phase' do
    expect(OpenRegister).to receive(:registers).and_return [beta_register]
    expect(OpenRegister).to receive(:registers).with(:alpha).and_return [alpha_register]
    expect(Register).to receive(:all).and_return [persisted_register]

    x = RegistersByPhase.new
    y = x.call
    expect(y).to eq({
      'proposed' => [],
      'prospect' => [],
      'discovery' => [],
      'alpha' => [alpha_register],
      'beta' => [persisted_register, beta_register],
      'live' => [],
    })
  end
end
