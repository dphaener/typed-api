require "rom-repository"

module Repos
  class User < ROM::Repository[:users]
    commands :create, :update

    def all
      users.to_a
    end
  end
end
