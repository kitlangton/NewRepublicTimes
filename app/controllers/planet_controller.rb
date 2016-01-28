class PlanetController < ApplicationController
  def update
    @planet = Planet.find params[:id]

    respond_to do |format|
      if @planet.update(planet_params)
        format.html { redirect_to :back }
        format.json { respond_with_bip(@planet) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@planet) }
      end
    end
  end

  private

  def planet_params
    params.require(:planet).permit(:name)
  end
end
