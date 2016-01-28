class Location < ActiveRecord::Base
  belongs_to :planet
  has_many :occurrences, as: :occurrable
  has_many :articles, through: :occurrences
end
