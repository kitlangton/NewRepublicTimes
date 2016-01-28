class Character < ActiveRecord::Base
  has_many :names

  def parse_name
    parsed = Nameable.parse(name)
    self.prefix = parsed.prefix
    self.first = parsed.first
    self.middle = parsed.middle
    self.last = parsed.last
    save
  end

  def to_hash
    { 'prefix' => prefix,
      'first' => first,
      'middle' => middle,
      'last' => last
    }
  end
end
