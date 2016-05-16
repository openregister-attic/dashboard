require 'rails_helper'
require 'openregister'

RSpec.feature "CreateRegisterProposals", type: :feature do

  before do
    allow(OpenRegister).to receive(:registers).and_return []
    allow(PublicBodies).to receive(:new).and_return -> { [] }
  end

  after { Register.all.each(&:destroy) }

  scenario 'submit new register form with valid parameters' do
    given_a_user_chooses_to_create_a_register_entry
    when_they_create_with_valid_parameters
    then_they_see_register_on_dashboard
  end

  scenario 'submit new register form with invalid parameters' do
    given_a_user_chooses_to_create_a_register_entry
    when_they_create_with_invalid_parameters
    then_they_see_validation_error_message
  end

  def given_a_user_chooses_to_create_a_register_entry
    visit registers_path
    click_on "Create register entry"
  end

  def when_they_create_with_valid_parameters
    attributes = valid_attributes
    attributes.each do |field, value|
      fill_in "register_#{field}", with: value unless field == :phase
    end
    choose attributes[:phase].capitalize
    click_create
  end

  def then_they_see_register_on_dashboard
    expect(current_path).to eql(root_path)
    expect(page.body).to have_content('country')
  end

  def when_they_create_with_invalid_parameters
    click_create
  end

  def then_they_see_validation_error_message
    expect(page).to have_content('Register name is required')
  end

  def valid_attributes overrides={}
    {
      register: 'country',
      registry: 'foreign-commonwealth-office',
      text: 'British English-language names and descriptive terms for countries',
      phase: 'beta'
    }.merge(overrides)
  end

  def click_create
    click_button 'Create register entry'
  end

end
