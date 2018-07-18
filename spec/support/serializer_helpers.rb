module SerializerHelper
  def serialize(obj, opts={})
    serializer_class =
      opts.delete(:serializer_class) || described_class

    serializer = serializer_class.send(:new, obj, opts)
    adapter = ActiveModelSerializers::Adapter.create(serializer, opts)

    adapter.to_json
  end

  def serialize_collection(collection, serializer_class)
    collection = [collection].flatten

    ActiveModelSerializers::SerializableResource.new(
      collection,
      each_serializer: serializer_class
    )
  end
end

RSpec.configure do |config|
  config.include SerializerHelper, type: :serializer
end
