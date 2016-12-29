require "dry/system/container"

class TypedAPI < Dry::System::Container
  configure do |config|
    # Use to automatically register files and/or directories into the app
    config.auto_register = %w(lib schema)

    load_paths!('lib')
  end
end
