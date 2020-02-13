class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    shelter = Shelter.new(shelter_params)
    attempt_create(shelter)
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    attempt_update(shelter)
  end

  def destroy
    shelter = Shelter.find(params[:id])
    attempt_destroy(shelter)
    redirect_to '/shelters'
  end

  private

    def shelter_params
      params.permit(:name, :address, :city, :state, :zip)
    end

    def attempt_create(shelter)
      if shelter.save
        affirm_create
      else
        refute_create(shelter)
      end
    end

    def affirm_create
      flash[:notice] = "Shelter created!"
      redirect_to '/shelters'
    end

    def refute_create(shelter)
      flash.now[:error] = shelter.errors.full_messages.to_sentence
      render :new
    end

    def attempt_update(shelter)
      if shelter.update(shelter_params)
        affirm_update(shelter)
      else
        refute_update(shelter)
      end
    end

    def affirm_update(shelter)
      flash[:notice] = "Shelter updated!"
      redirect_to "/shelters/#{shelter.id}"
    end

    def refute_update(shelter)
      flash[:error] = shelter.errors.full_messages.to_sentence
      redirect_to "/shelters/#{shelter.id}/edit"
    end

    def attempt_destroy(shelter)
      if shelter.pets.pending.empty?
        favorites.delete_pets(shelter.pets.pluck(:id))
        Shelter.destroy(shelter.id)
      else
        flash[:notice] = "You cannot delete a shelter with approved pets."
      end
    end
end
