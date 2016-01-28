class Occurrence < ActiveRecord::Base
  belongs_to :article
  belongs_to :occurrable, polymorphic: true
end
