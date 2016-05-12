class RegisterCreate

  def initialize params
    @params = params
  end

  def call
    Register.new(@params)
  end

end
