require "rom-repository"

module Repositories
  class TodoLists < ROM::Repository[:todo_lists]
    commands :create, :update, :destroy
    relations :todos

    def all
      aggregate(:todos)
        .as(TodoList)
        .to_a
    end

    def by_id(id)
      aggregate(:todos)
        .by_id(id)
        .as(TodoList)
        .one
    end

    def for_user(user_id)
      aggregate(:todos)
        .where(user_id: user_id)
        .as(TodoList)
        .to_a
    end
  end
end
