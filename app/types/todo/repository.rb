require "rom-repository"

module Repos
  class Todo < ROM::Repository[:users]
    commands :create, :update

    def all
      todos.to_a
    end
  end
end
