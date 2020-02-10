class ApplicationPetsController < ApplicationController
  def update
    application_pet = ApplicationPet.find_by(application_id: params[:application_id], pet_id: params[:pet_id])
    params[:approval] == 'approve' ? attempt_approve(application_pet) : revoke(application_pet)
  end

  private

  def attempt_approve(application_pet)
    revoke(application_pet) if application_pet.pet.status == "Pending"
    approve(application_pet) if application_pet.pet.status == "Adoptable"
    redirect_to "/pets/#{application_pet.pet.id}"
  end

  def revoke(application_pet)
    application_pet.update(approved: false)
    application_pet.pet.update(status: "Adoptable")
    redirect_back(fallback_location: "/pets")
  end

  def approve(application_pet)
    application_pet.update(approved: true)
    application_pet.pet.update(status: "Pending")
  end
end
