require "rom"

module Relations
  class Todos < ROM::Relation[:sql]
    schema(:todos) do
      associations do
        belongs_to :user
      end
    end
  end
end
