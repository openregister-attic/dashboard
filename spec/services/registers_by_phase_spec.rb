require 'rails_helper'
require 'openregister'

RSpec.describe RegistersByPhase do
  let(:beta_register) { double(register: 'country', phase: 'beta') }
  let(:alpha_register) { double(register: 'address', phase: 'alpha') }

  it 'returns registers from API calls grouped by phase' do
    expect(OpenRegister).to receive(:registers).and_return [beta_register]
    expect(OpenRegister).to receive(:registers).with(from_openregister: true).and_return [alpha_register]

    x = RegistersByPhase.new
    y = x.call
    expect(y).to eq({
      "alpha" => [alpha_register],
      "beta" => [beta_register],
      "discovery" => [],
      "live" => [],
      "proposed" => [],
      "prospect" => [],
    })
  end
end
