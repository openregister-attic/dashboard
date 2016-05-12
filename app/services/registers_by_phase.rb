class RegistersByPhase

  EMPTY = Rails.configuration.phases.each_with_object({}) do |phase, hash|
    hash[phase] = []
  end.freeze unless defined? EMPTY

  def call
    registers = OpenRegister.registers + OpenRegister.registers(from_openregister: true)
    registers.delete_if {|r| r.register.nil?}
    registers.sort_by!(&:register)
    by_phase = registers.group_by(&:phase)

    RegistersByPhase::EMPTY.merge(by_phase)
  rescue SocketError => e
    if Rails.configuration.stub_registers_api_when_offline
      RegistersByPhase::EMPTY
    else
      raise e
    end
  end

end
