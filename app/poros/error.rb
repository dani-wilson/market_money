class Error
  attr_reader :error_message,
              :status_code

  def initialize(error_message, status_code)
    @error_message = error_message
    @status_code = status_code
  end
end