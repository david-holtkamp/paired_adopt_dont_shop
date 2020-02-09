class ApplicationsController < ApplicationController
  def new
    @pets = Pet.find(favorites.contents)
  end

  def create
    application = Application.new(application_params)
    if application.save   #possible poro refactor opportunity?
      application_pets = favorites.contents.find_all do |pet_id|
        params.keys.include?("pet_id-#{pet_id}")
      end
      application_pets.each do |pet|
        application.pets << Pet.find(pet)
        favorites.delete_pet(pet)
      end
      flash[:notice] = "You have successfully submitted your application!"
      redirect_to '/favorites'
    else
      @pets = Pet.find(favorites.contents)
      flash[:notice] = "You must complete the form in order to submit the application."
      render :new
    end
  end

  private

    def application_params
      params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
    end
end
