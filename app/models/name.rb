class Name < ActiveRecord::Base
  belongs_to :character
  has_many :occurrences, as: :occurrable
  has_many :articles, through: :occurrences

  def to_hash
    { 'prefix' => prefix,
      'first' => first,
      'middle' => middle,
      'last' => last
    }
  end
end
