module RequestHelpers
  def serialize(obj, serializer_class, options = {})
    serializer_class.new(obj, options)
  end

  def serialize_all(collection, serializer_class)
    collection = [collection].flatten

    ActiveModelSerializers::SerializableResource.new(
      collection,
      each_serializer: serializer_class
    )
  end
end

RSpec.configure do |config|
  config.include RequestHelpers, type: :request
end
