require 'rails_helper'

RSpec.describe Register, type: :model do

  def valid_attributes overrides={}
    {
      register: 'ISO Country',
      registry: 'foreign-commonwealth-office',
      text: 'British English-language names and descriptive terms for countries',
      phase: 'beta'
    }.merge(overrides)
  end

  after { Register.all.each(&:destroy) }

  it 'creates with valid attributes' do
    register = described_class.new valid_attributes
    expect(register).to be_valid
  end

  it 'converts register name to dashed lowercase string' do
    register = described_class.new valid_attributes
    register.valid?
    expect(register.register).to eq 'iso-country'
  end

  it 'stores phase as string' do
    register = described_class.new valid_attributes
    expect(register.phase).to eq 'beta'
  end

  it 'is invalid when register blank' do
    register = described_class.new valid_attributes(register: nil)
    expect(register).not_to be_valid
    expect(register.errors.full_messages).to eq ["Register is required"]
  end

  it 'defaults phase to "proposed" when phase not provided' do
    register = described_class.new valid_attributes.except(:phase)
    expect(register.phase).to eq 'proposed'
  end

  it 'is invalid when register name is a duplicate' do
    existing_register = described_class.new valid_attributes
    existing_register.save

    register = described_class.new valid_attributes
    expect(register).not_to be_valid
    expect(register.errors.full_messages).to eq ["Register is already taken"]
  end
end
