require "rom-repository"

module Repositories
  class Todos < ROM::Repository[:todos]
    commands :create, :update, :destroy

    def all
      todos.as(Todo).to_a
    end

    def for_todo_list(todo_list_id)
      todos
        .where(todo_list_id: todo_list_id)
        .as(Todo)
        .to_a
    end
  end
end
