require "rom-repository"

module Repositories
  class Users < ROM::Repository[:users]
    commands :create, :update, :destroy
    relations :todo_lists

    def all
      aggregate(:todo_lists)
        .as(User)
        .to_a
    end

    def by_id(id)
      aggregate(:todo_lists)
        .by_id(id)
        .as(User)
        .one
    end
  end
end
