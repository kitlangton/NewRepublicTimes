class Article < ActiveRecord::Base
  has_many :occurrences
  has_many :names, through: :occurrences, source: :occurrable, source_type: 'Name'
  has_many :locations, through: :occurrences, source: :occurrable, source_type: 'Location'
end
