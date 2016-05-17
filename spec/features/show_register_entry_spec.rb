require 'rails_helper'
require 'openregister'

RSpec.feature "ShowRegisterEntry", type: :feature do

  before do
    allow(OpenRegister).to receive(:registers).and_return []
    allow(PublicBodies).to receive(:new).and_return -> { [] }
  end

  after { Register.all.each(&:destroy) }

  scenario 'view register entry and return to dashboard' do
    given_a_user_sees_a_register_entry_on_dashboard
    when_they_choose_to_view_the_register_entry
    then_they_see_register_entry_details

    when_they_choose_to_return_to_dashboard
    then_they_see_register_dashboard
  end

  def given_a_user_sees_a_register_entry_on_dashboard
    RegisterCreate.new(valid_attributes).call
    visit registers_path
    within '#content' do
      expect(page).to have_content("country")
    end
  end

  def when_they_choose_to_view_the_register_entry
    click_on "country"
  end

  def then_they_see_register_entry_details
    within '#content' do
      valid_attributes.each do |key, value|
        value = value.capitalize unless [:registry, :text].include?(key)
        expect(page).to have_content(value)
      end
    end
  end

  def when_they_choose_to_return_to_dashboard
    within('#content') do
      click_on 'Return to dashboard'
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

end
