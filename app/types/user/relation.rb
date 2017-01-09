require "rom"

module Relations
  class Users < ROM::Relation[:sql]
    schema(:users) do
      associations do
        has_many :todos
      end
    end
  end
end
