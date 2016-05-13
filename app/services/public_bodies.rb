class PublicBodies

  def call
    register = OpenRegister.register 'public-body', from_openregister: true
    public_bodies = register._all_records
    public_bodies.sort_by!(&:name)
    public_bodies
  rescue SocketError => e
    if Rails.configuration.stub_registers_api_when_offline
      Struct.new('PublicBody', :public_body, :name) unless defined? Stuct::PublicBody
      [
        Struct::PublicBody.new('cabinet-office', 'Cabinet Office'),
        Struct::PublicBody.new('ministry-of-justice', 'Ministry of Justice')
      ]
    else
      raise e
    end
  end

end
