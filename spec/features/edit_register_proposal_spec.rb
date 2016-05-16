require 'rails_helper'
require 'openregister'

RSpec.feature "EditRegisterProposal", type: :feature do

  before do
    allow(OpenRegister).to receive(:registers).and_return []
    allow(PublicBodies).to receive(:new).and_return -> { [] }
  end

  after { Register.all.each(&:destroy) }

  scenario 'update register entry with valid parameters' do
    given_a_user_chooses_to_edit_a_register_entry
    when_they_update_with_valid_parameters
    then_they_see_register_on_dashboard_with_changed_parameters
  end

  scenario 'update register entry with invalid parameters' do
    given_a_user_chooses_to_edit_a_register_entry
    when_they_update_with_invalid_parameters
    then_they_see_validation_error_message
  end

  def given_a_user_chooses_to_edit_a_register_entry
    RegisterCreate.new(valid_attributes).call
    visit registers_path
    click_on "country"
  end

  def when_they_update_with_valid_parameters
    within 'form.edit_register' do
      attributes = valid_attributes
      attributes.each do |field, value|
        fill_in "register_#{field}", with: value unless field == :phase
      end
      choose 'Live'
      click_update
    end
  end

  def then_they_see_register_on_dashboard_with_changed_parameters
    expect(current_path).to eql(root_path)
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
