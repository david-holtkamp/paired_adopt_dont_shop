class ApplicationsController < ApplicationController
  def new
    @pets = Pet.find(favorites.contents)
  end

  def create
    application = Application.new(application_params)
    if application.save
      application.pets << Pet.find(params[:applied_for])
      params[:applied_for].each { |pet| favorites.delete_pet(pet) }
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
