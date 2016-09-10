module ErrorRepresenter
  include Roar::JSON

  self.representation_wrap = true

  property :message
  property :validation_errors

  
end
