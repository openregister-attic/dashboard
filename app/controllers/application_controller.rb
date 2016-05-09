require 'openregister'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
    @registers = OpenRegister.registers + OpenRegister.registers(from_openregister: true)
    set_vars!
    @registers.delete_if {|r| r.register.nil?}
    @registers.sort_by!(&:register)
    by_phase = @registers.group_by(&:phase)

    @registers_by_phase = Rails.configuration.phases.each_with_object({}) do |phase, hash|
      hash[phase] = by_phase[phase] || []
    end

    render 'dashboard'
  end

  private

  def set_vars!
    register = @registers.first
    register.instance_variables.each do |var|
      val = register.instance_variable_get(var)
      register.send("#{var.to_s.sub('@','')}=".to_sym, val)
    end
    register._from_openregister = false unless register.try(:_from_openregister)
  end
end
