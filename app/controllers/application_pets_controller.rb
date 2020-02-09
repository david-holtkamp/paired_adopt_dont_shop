class ApplicationPetsController < ApplicationController
  def update
    application_pet = ApplicationPet.find_by(application_id: params[:application_id], pet_id: params[:pet_id])
    application_pet.update(approved: true)
    application_pet.pet.update(status: "Pending")
    redirect_to "/pets/#{application_pet.pet.id}"
  end
end
