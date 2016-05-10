class RegistersController < ApplicationController

  def index
    @registers_by_phase = RegistersByPhase.new.call
  end

end
