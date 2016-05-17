class RegisterUpdate

  def initialize id, params
    @params = params
    @id = id
  end

  def call
    if Register.where(id: @id).exists?
      register = Register.find(@id)
      register.update_attributes(@params)
      register
    end
  end

end
