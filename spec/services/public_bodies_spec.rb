require 'rails_helper'
require 'openregister'

RSpec.describe PublicBodies do

  Struct.new('PublicBody', :public_body, :name) unless defined? Stuct::PublicBody

  let(:cabinet_office) { Struct::PublicBody.new('cabinet-office', 'Cabinet Office') }
  let(:moj) { Struct::PublicBody.new('ministry-of-justice', 'Ministry of Justice') }
  let(:register) { double(_all_records: [moj, cabinet_office]) }

  after { Rails.cache.clear }

  it 'returns public bodies from API calls ordered by name' do
    expect(OpenRegister).to receive(:register).and_return register

    expect(PublicBodies.new.call).to eq([cabinet_office, moj])
  end

  it 'returns public bodies from cache when called a second time' do
    expect(OpenRegister).to receive(:register).and_return register
    PublicBodies.new.call

    expect(OpenRegister).not_to receive(:register)
    expect(PublicBodies.new.call).to eq([cabinet_office, moj])
  end

end
