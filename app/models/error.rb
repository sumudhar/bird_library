class Error
  attr_accessor :message
  attr_accessor :validation_errors

  def initialize(options={})
    @message = options[:message] or nil
    @validation_errors = options[:validation_errors] or nil
  end

end
