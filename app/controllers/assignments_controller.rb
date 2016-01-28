class AssignmentsController < ApplicationController
  def show
    @article = Article.find(params[:article])
    @names, @locations = NamedEntities.new.process(@article.body)
    @characters = Character.all
    @planets = Planet.all

    @locations.each do |location|
      next unless planet = location.planet
      @article.body.gsub!(/#{location.name}/i, planet.name)
    end

    selected = []

    @names.each do |name|
      next unless character = name.character
      @article.title.gsub!(name.first, character.first) if name.first && character.first
      @article.title.gsub!(name.middle, character.middle.to_s) if name.middle && character.middle
      @article.title.gsub!(name.last, character.last) if name.last && character.last

      @article.body.gsub!(name.prefix, character.prefix) if name.prefix && character.prefix
      @article.body.gsub!(name.first, character.first) if name.first && character.first
      @article.body.gsub!(name.middle, character.middle.to_s) if name.middle && character.middle && !character.middle.empty?
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
