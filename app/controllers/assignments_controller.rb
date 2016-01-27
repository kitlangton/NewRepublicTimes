class AssignmentsController < ApplicationController

  def show
    @entities = NamedEntities.new.process
  end

end
