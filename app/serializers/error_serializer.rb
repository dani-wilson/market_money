class ErrorSerializer
  def initialize(error_object)
    @error_object = error_object
  end

  def self.serialize_json(error_object)
    {
      errors: [
        {
          status: error_object.status.to_s,
          title: error_object.message
        }
      ]
    }
  end
end
