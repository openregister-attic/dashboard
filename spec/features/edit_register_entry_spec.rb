require 'rails_helper'
require 'openregister'

RSpec.feature "EditRegisterEntry", type: :feature do

  before do
    allow(OpenRegister).to receive(:registers).and_return []
    allow(PublicBodies).to receive(:new).and_return -> { [] }
  end

  after { Register.all.each(&:destroy) }

  scenario 'update register entry with valid parameters' do
    given_a_user_chooses_to_edit_a_register_entry
    when_they_update_with_valid_parameters
    then_they_see_register_entry_with_changed_parameters
  end

  scenario 'update register entry with invalid parameters' do
    given_a_user_chooses_to_edit_a_register_entry
    when_they_update_with_invalid_parameters
    then_they_see_validation_error_message
  end

  scenario 'cancel update register entry' do
    given_a_user_chooses_to_edit_a_register_entry
    when_they_cancel_register_entry
    then_they_see_register_dashboard
  end

  def given_a_user_chooses_to_edit_a_register_entry
    RegisterCreate.new(valid_attributes).call
    visit registers_path
    click_on "country"
    click_on "Edit register entry"
  end

  def when_they_update_with_valid_parameters
    within 'form.edit_register' do
      choose 'Live'
      click_update
    end
  end

  def then_they_see_register_entry_with_changed_parameters
    expect(current_path).to eql(register_path(Register.last))
    within('.phase-circle') do
      expect(page).to have_content('Live')
    end
  end

  def when_they_update_with_invalid_parameters
    within 'form.edit_register' do
      fill_in "register_register", with: ""
      click_update
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

  def click_update
    click_button 'Update register entry'
  end

end
