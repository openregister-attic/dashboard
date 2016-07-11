class RegistersByPhase

  EMPTY = Register::PHASES.each_with_object({}) do |phase, hash|
    hash[phase] = []
  end.freeze unless defined? EMPTY

  def call
    registers = Register.all.to_a
    add_deployed_registers! registers

    registers.sort_by!(&:register)
    by_phase = registers.group_by(&:phase)

    RegistersByPhase::EMPTY.merge(by_phase)
  end

  private

  def add_deployed_registers! registers
    registers.push(
      *OpenRegister.registers
    ).push(
      *OpenRegister.registers(:alpha)
    ).push(
      *OpenRegister.registers(:discovery)
    )
    registers.delete_if {|r| r.register.nil?}
    registers
  rescue SocketError => e
    raise e unless Rails.configuration.stub_registers_api_when_offline
  end

end
