require 'rails_helper'
require 'openregister'

RSpec.feature "CreateRegisterEntry", type: :feature do

  before do
    allow(OpenRegister).to receive(:registers).and_return []
    allow(PublicBodies).to receive(:new).and_return -> { [] }
  end

  after { Register.all.each(&:destroy) }

  scenario 'create new register entry with valid parameters' do
    given_a_user_chooses_to_create_a_register_entry
    when_they_create_with_valid_parameters
    then_they_see_register_on_dashboard
  end

  scenario 'create new register entry with invalid parameters' do
    given_a_user_chooses_to_create_a_register_entry
    when_they_create_with_invalid_parameters
    then_they_see_validation_error_message
  end

  scenario 'cancel new register entry' do
    given_a_user_chooses_to_create_a_register_entry
    when_they_cancel_register_entry
    then_they_see_register_dashboard
  end

  def given_a_user_chooses_to_create_a_register_entry
    visit registers_path
    click_on "Create register entry"
  end

  def when_they_create_with_valid_parameters
    within 'form.new_register' do
      attributes = valid_attributes
      attributes.each do |field, value|
        fill_in "register_#{field}", with: value unless field == :phase
      end
      choose attributes[:phase].capitalize
      click_create
    end
  end

  def then_they_see_register_on_dashboard
    expect(current_path).to eql(root_path)
    expect(page.body).to have_content('country')
  end

  def when_they_create_with_invalid_parameters
    within 'form.new_register' do
      click_create
    end
  end

  def then_they_see_validation_error_message
    within('#content') do
      expect(page).to have_content('Register name is required')
    end
  end

  def when_they_cancel_register_entry
    within('#content') do
      click_on 'Cancel'
    end
  end

  def then_they_see_register_dashboard
    expect(current_path).to eql(registers_path)
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
