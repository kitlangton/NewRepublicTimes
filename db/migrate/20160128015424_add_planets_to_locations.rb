class AddPlanetsToLocations < ActiveRecord::Migration
  def change
    add_reference :locations, :planet, index: true, foreign_key: true
  end
end
