class LocationsController < ApplicationController
  def update
    @location = Location.find params[:id]

    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to :back }
        format.json { respond_with_bip(@location) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@location) }
      end
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :planet_id)
  end
end
