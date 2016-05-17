require 'rails_helper'
require 'openregister'

RSpec.feature "ShowRegisterEntry", type: :feature do

  before do
    allow(OpenRegister).to receive(:registers).and_return [
      double(attributes(register: 'api-country', _uri: 'http://country.register/'))
    ]
    allow(OpenRegister).to receive(:registers).with(from_openregister: true).and_return []
    allow(PublicBodies).to receive(:new).and_return -> { [] }
  end

  after { Register.all.each(&:destroy) }

  scenario 'view register entry and return to dashboard' do
    register = 'proposed-country'
    given_a_user_sees_a_register_entry_on_dashboard register
    when_they_choose_to_view_the_register_entry register
    then_they_see_register_entry_details register
    and_they_see_link_to_edit_register

    when_they_choose_to_return_to_dashboard
    then_they_see_register_dashboard
  end

  scenario 'view register entry created from API and return to dashboard' do
    register = 'api-country'
    given_a_user_sees_an_api_register_entry_on_dashboard register
    when_they_choose_to_view_the_register_entry register
    then_they_see_register_entry_details register
    and_they_see_link_to_register_uri
    and_they_do_not_see_link_to_edit_register

    when_they_choose_to_return_to_dashboard
    then_they_see_register_dashboard
  end

  def given_a_user_sees_a_register_entry_on_dashboard register
    RegisterCreate.new(attributes(register: register)).call
    visit registers_path
    within '#content' do
      expect(page).to have_content(register)
    end
  end

  def given_a_user_sees_an_api_register_entry_on_dashboard register
    visit registers_path
    within '#content' do
      expect(page).to have_content(register)
    end
  end

  def when_they_choose_to_view_the_register_entry register
    click_on register
  end

  def then_they_see_register_entry_details register
    within '#content' do
      attributes(register: register).each do |key, value|
        value = value.capitalize unless [:registry, :text].include?(key)
        expect(page).to have_content(value)
      end
    end
  end

  def and_they_see_link_to_edit_register
    within('a.button') do
      expect(page).to have_content('Edit register entry')
    end
  end

  def and_they_do_not_see_link_to_edit_register
    within('#content') do
      expect(page).not_to have_content('Edit register entry')
    end
  end

  def and_they_see_link_to_register_uri
    within('#content') do
      expect(page).to have_content('http://country.register/')
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

  def attributes overrides={}
    {
      register: 'country',
      registry: 'foreign-commonwealth-office',
      text: 'British English-language names and descriptive terms for countries',
      phase: 'beta'
    }.merge(overrides)
  end

end
