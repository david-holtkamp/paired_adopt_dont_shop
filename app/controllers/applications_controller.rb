class ApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:id])
  end

  def new
    @pets = Pet.where(id: favorites.contents)
  end

  def create
    pets_selected = params[:applied_for] && !params[:applied_for].empty?
    application = Application.new(application_params)
    pets_selected && application.save ? successful_application(application) : failed_application
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
      favorites.delete_pets(params[:applied_for])
      flash[:notice] = "You have successfully submitted your application!"
      redirect_to '/favorites'
    end

    def failed_application
      @pets = Pet.find(favorites.contents)
      flash[:notice] = "You must complete the form in order to submit the application."
      render :new
    end
end
