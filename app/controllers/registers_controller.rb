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
    if @register.persisted?
      redirect_to action: :index
    else
      @public_bodies = PublicBodies.new.call
      render :new
    end
  end

  def edit
    @register = Register.find(params[:id])
    @public_bodies = PublicBodies.new.call
  end

  def update
    @register = RegisterUpdate.new(params[:id], register_params).call
    if !@register.try(:changed?)
      redirect_to action: :index
    else
      @public_bodies = PublicBodies.new.call
      render :edit
    end
  end

  private

  def register_params
    params.require(:register).
      permit(:register, :text, :registry, :phase)
  end

end
