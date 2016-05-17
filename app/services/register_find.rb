class RegisterFind

  def initialize id
    @id = id
  end

  def call
    if Register.where(id: @id).exists?
      register = Register.find(@id)
    else
      registers = RegistersByPhase.new.call.values.flatten

      registers.detect {|r| r.register == @id }
    end
  end

end