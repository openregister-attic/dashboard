class RecordsController < ApplicationController

  def new
    @register = RegisterFind.new(params[:register]).call
    @record = @register._records.first
    @public_bodies = PublicBodies.new.call
  end

end
