class CharactersController < ApplicationController
  def update
    @character = Character.find params[:id]

    respond_to do |format|
      if @character.update(character_params)
        format.html { redirect_to :back }
        format.json { respond_with_bip(@character) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@character) }
      end
    end
  end

  private

  def character_params
    params.require(:character).permit(:prefix,:first,:middle,:last)
  end
end
