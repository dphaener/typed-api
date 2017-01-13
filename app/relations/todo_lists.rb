require "rom"

module Relations
  class TodoLists < ROM::Relation[:sql]
    schema(:todo_lists) do
      attribute :id, Types::Serial
      attribute :title, Types::Strict::String
      attribute :user_id, Types::ForeignKey(:users)

      primary_key :id

      associations do
        has_many :todos
      end

      def by_id(id)
        where(id: id)
      end
    end
  end
end
