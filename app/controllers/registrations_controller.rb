class RegistrationsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @registration = current_user.registrations.create(registration_params)

    redirect_to @registration.event, notice: "Thank you for registering!"
  end

  private

  def registration_params
    params.require(:registration).permit(:starts_at, :ends_at, :price, :total, :room_id)
  end
end
