class NamesController < ApplicationController
  def index
    @names = Name.all
    @characters = Character.all
  end

  def show
  end

  def edit
  end

  def update
    @name = Name.find params[:id]

    respond_to do |format|
      if @name.update(name_params)
        format.html { redirect_to :back }
        format.json { respond_with_bip(@name) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@name) }
      end
    end
  end

  private

  def name_params
    params.require(:name).permit(:prefix,:first,:middle,:last,:character_id)
  end
end
