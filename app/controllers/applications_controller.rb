class ApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:id])
  end

  def new
    @pets = Pet.find(favorites.contents)
  end

  def create
    if params[:applied_for] && params[:applied_for].length > 0
      application = Application.new(application_params)
      application.save ? successful_application(application) : failed_application
    else
      failed_application
    end
  end

  def show
    @application = Application.find(params[:id])
  end

  private

    def application_params
      params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
    end

    def successful_application(application)
      application.pets << Pet.find(params[:applied_for])
      params[:applied_for].each { |pet| favorites.delete_pet(pet) }
      flash[:notice] = "You have successfully submitted your application!"
      redirect_to '/favorites'
    end

    def failed_application
      @pets = Pet.find(favorites.contents)
      flash.now[:notice] = "You must complete the form in order to submit the application."
      render :new
    end
end
