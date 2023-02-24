# frozen_string_literal: true

# ActiveModelSerializers.config.adapter = :json_api
# ActiveModelSerializers.config.adapter = :json
# Rails.application.config.action_dispatch.cookies_serializer = :json

ActiveModelSerializers.config do |config|
  config.adapter = :json_api
end

ActiveModelSerializers.config.key_transform = :unaltered