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

  scenario 'submit new register form with valid parameters' do
    visit new_register_path
    attributes = valid_attributes
    attributes.each do |field, value|
      fill_in "register_#{field}", with: value unless field == :phase
    end
    choose attributes[:phase].capitalize
    click_button 'Create Register'
    expect(current_path).to eql(registers_path)
  end

  scenario 'submit new register form without parameters' do
    visit new_register_path
    click_button 'Create Register'
    expect(page).to have_content('Register name is required')
  end
end
