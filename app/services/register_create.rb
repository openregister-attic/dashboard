class RegisterCreate

  def initialize params
    @params = params
  end

  def call
    register = Register.new(@params)
    register.save
    register
  end

end
