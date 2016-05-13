require 'rails_helper'

RSpec.feature "CreateRegisterProposals", type: :feature do

  def valid_attributes overrides={}
    {
      register: 'country',
      registry: 'foreign-commonwealth-office',
      text: 'British English-language names and descriptive terms for countries',
      phase: 'beta'
    }.merge(overrides)
  end

  before do
    allow(RegistersByPhase).to receive(:new).and_return -> { RegistersByPhase::EMPTY }
    allow(PublicBodies).to receive(:new).and_return -> { [] }
  end

  after { Register.all.each(&:destroy) }

  scenario 'submit new register form with valid parameters' do
    visit registers_path
    click_on "Create proposed register"

    attributes = valid_attributes
    attributes.each do |field, value|
      fill_in "register_#{field}", with: value unless field == :phase
    end
    choose attributes[:phase].capitalize
    click_button 'Create Register'
    expect(current_path).to eql(root_path)
  end

  scenario 'submit new register form without parameters' do
    visit new_register_path
    click_button 'Create Register'
    expect(page).to have_content('Register name is required')
  end
end
