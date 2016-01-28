class Name < ActiveRecord::Base
  belongs_to :character

  def to_hash
    { 'prefix' => prefix,
      'first' => first,
      'middle' => middle,
      'last' => last
    }
  end
end
