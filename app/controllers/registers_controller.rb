class RegistersController < ApplicationController

  def index
    @registers = OpenRegister.registers + OpenRegister.registers(from_openregister: true)
    @registers.delete_if {|r| r.register.nil?}
    @registers.sort_by!(&:register)
    by_phase = @registers.group_by(&:phase)

    @registers_by_phase = Rails.configuration.phases.each_with_object({}) do |phase, hash|
      hash[phase] = by_phase[phase] || []
    end
  end

end
