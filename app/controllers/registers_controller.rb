class RegistersController < ApplicationController

  def index
    @registers_by_phase = RegistersByPhase.new.call
  end

  def new
    @register = Register.new
    @public_bodies = PublicBodies.new.call
  end

  def create
    @register = RegisterCreate.new(register_params).call
    if @register.save
      redirect_to action: :index
    else
      @public_bodies = PublicBodies.new.call
      render :new
    end
  end

  private

  def register_params
    params.require(:register).
      permit(:register, :text, :registry, :phase)
  end

end
