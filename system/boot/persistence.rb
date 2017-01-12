TypedAPI.finalize(:persistence) do |persistence|
  init do
    require "rom-sql"
  end

  start do
    configuration = ROM::Configuration.new(:sql, "sqlite://#{Dir.pwd}/sqlite.db")
    configuration.auto_registration("#{Dir.pwd}/app", namespace: "Relations")
    container = ROM.container(configuration)

    persistence.register('persistence.db', container)
  end

  stop do
    db.close_connection
  end
end
