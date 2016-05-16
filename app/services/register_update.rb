class RegisterUpdate

  def initialize id, params
    @params = params
    @id = id
  end

  def call
    register = Register.find(@id)
    register.update_attributes(@params)
    register
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end

end
