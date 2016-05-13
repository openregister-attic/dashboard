require 'rails_helper'
require 'openregister'

RSpec.describe PublicBodies do

  let(:cabinet_office) { double(name: 'Cabinet Office') }
  let(:moj) { double(name: 'Ministry of Justice') }
  let(:register) { double(_all_records: [moj, cabinet_office]) }

  it 'returns public bodies from API calls ordered by name' do
    expect(OpenRegister).to receive(:register).and_return register

    expect(PublicBodies.new.call).to eq([cabinet_office, moj])
  end
end
