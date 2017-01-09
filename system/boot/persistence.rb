TypedAPI.finalize(:persistence) do |persistence|
  init do
    require "rom-sql"
    require_relative "#{Dir.pwd}/app/types/user/relation"
    require_relative "#{Dir.pwd}/app/types/todo/relation"
  end

  start do
    configuration = ROM::Configuration.new(:sql, "sqlite://#{Dir.pwd}/sqlite.db")
    configuration.register_relation(Relations::Users)
    configuration.register_relation(Relations::Todos)
    container = ROM.container(configuration)

    persistence.register('persistence.db', container)
  end

  stop do
    db.close_connection
  end
end
