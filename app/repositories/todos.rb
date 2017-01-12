require "rom-repository"

module Repositories
  class Todos < ROM::Repository[:todos]
    commands :create, :update

    def all
      todos.to_a
    end

    def for_user(user_id)
      todos
        .where(user_id: user_id)
        .as(Todo)
        .to_a
    end
  end
end
