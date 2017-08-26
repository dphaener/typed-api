require "kanji/container"

module Kanji
  Container.finalize(:config) do |container|
    path = container.root.join("config").join("application.yml")
    yaml = File.exist?(path) ? YAML.load_file(path) : {}
    schema = yaml.fetch(env.to_s, {})

    schema.keys.each do |key|
      ENV[key] ||= schema.fetch(key, nil)
    end
  end
end
