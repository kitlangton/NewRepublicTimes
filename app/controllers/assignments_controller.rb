class AssignmentsController < ApplicationController
  def show
    @article = Article.find(params[:article])
    @names, @locations = NamedEntities.new.process(@article.body)
    @characters = Character.all
    @planets = Planet.all

    @locations.each do |location|
      planet = @planets.sample
      @article.body.gsub!(/#{location}/i, planet.name)
    end

    @article.body.gsub!(/Mr\./, "Captain")
    @article.body.gsub!(/Ms\.|Ms\./, "Princess")
    selected = []

    @names.each do |name|
      character = (name.character || @characters.sample)
      @article.body.gsub!(name.first, character.first) if name.first && character.first
      @article.body.gsub!(name.middle, character.middle.to_s) if name.middle && character.middle
      @article.body.gsub!(name.last, character.last) if name.last && character.last
    end
  end

  def character_for(name, selected)
    candidates = Character.all.select { |char|
      char.gender == name.gender if name.gender
      bool = true
      bool = false if selected.include?(char)
      bool = false if name.first && char.first.nil?
      bool = false if name.middle && char.middle.nil?
      bool = false if name.last && char.last.nil?
      bool
    }
    p candidates
    choice = candidates.sample
    selected << choice
    choice
  end
end
