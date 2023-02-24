module ApplicationHelper
  def json_for(target, options = {})
    options[:scope] ||= self
    options[:url_options] ||= url_options
    # target.active_model_serializer.new(target, options).to_json
    ActiveModelSerializers::SerializableResource.new(target, options).as_json
  end
end
