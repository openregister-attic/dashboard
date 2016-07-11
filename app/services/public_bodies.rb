class PublicBodies

  def call
    Rails.cache.fetch('public-bodies', expires_in: 1.day) do
      register = OpenRegister.register 'public-body', :alpha
      public_bodies = register._all_records
      public_bodies.sort_by!(&:name)
      public_bodies
    end
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
