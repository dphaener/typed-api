require "rom-repository"

module Repositories
  class Users < ROM::Repository[:users]
    commands :create, :update
    relations :todos

    def all
      aggregate(:todos)
        .as(User)
        .to_a
    end

    def by_id(id)
      aggregate(:todos)
        .by_id(id)
        .as(User)
        .one
    end
  end
end
