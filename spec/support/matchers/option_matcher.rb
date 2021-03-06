require "rspec/expectations"

RSpec::Matchers.define :have_option do |expected_option|
  match do |object|
    options = object.
      instance_variable_get(:@__initializer_builder__).
      instance_variable_get(:@options)

    option = options.find { |opt| opt.source == expected_option }

    if @expected_type
      !option.nil? && option.coercer.type == @expected_type
    else
      !option.nil?
    end
  end

  chain :of_type do |expected_type|
    @expected_type = expected_type
  end

  failure_message do |object|
    "#{object} was expected to have option #{expected_option}"
  end
end
