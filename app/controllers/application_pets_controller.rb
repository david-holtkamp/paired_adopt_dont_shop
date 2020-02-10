class ApplicationPetsController < ApplicationController
  def update
    application_pet = ApplicationPet.find_by(application_id: params[:application_id], pet_id: params[:pet_id])
    unless application_pet.pet.status == "Pending"
      application_pet.update(approved: true)
      application_pet.pet.update(status: "Pending")
    else
      flash[:notice] = "#{application_pet.pet.name} is already pending adoption."
    end
    redirect_to "/pets/#{application_pet.pet.id}"
  end
end
