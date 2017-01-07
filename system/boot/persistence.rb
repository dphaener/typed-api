TypedAPI.finalize(:persistence) do |persistence|
  init do
    require "rom"
    require "rom-sql"
  end

  start do
    configuration = ROM::Configuration.new(:sqlite, "sqlite::memory")
    configuration.auto_load("../../db")
    container = ROM.container(configuration)

    persistence.register('persistence.db', container)
  end

  stop do
    db.close_connection
  end
end
