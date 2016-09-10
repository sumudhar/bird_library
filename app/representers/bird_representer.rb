module BirdRepresenter
  include Roar::JSON
  include Representable::JSON
  property :id
  property :name
  property :family
  property :continents
  property :added
  property :visible
end
