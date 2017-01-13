require "rom"

module Relations
  class Todos < ROM::Relation[:sql]
    schema(:todos) do
      attribute :id, Types::Serial
      attribute :todo_list_id, Types::ForeignKey(:todo_lists)
      attribute :title, Types::Strict::String
      attribute :description, Types::Strict::String
      attribute :complete, Types::Strict::Bool

      primary_key :id

      associations do
        belongs_to :todo_list
      end
    end

    def by_id(id)
      where(id: id)
    end

    def completed
      where(complete: true)
    end
  end
end
