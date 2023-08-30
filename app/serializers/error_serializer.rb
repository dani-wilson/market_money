class ErrorSerializer
  def self.format_error(error)
    {
      errors: [
        {
          details: error.message
        }
      ]
    }
  end
end
