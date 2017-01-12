require "rom"

module Relations
  class Todos < ROM::Relation[:sql]
    schema(:todos) do
      attribute :id, Types::Serial
      attribute :user_id, Types::ForeignKey(:users)
      attribute :title, Types::Strict::String
      attribute :description, Types::Strict::String
      attribute :complete, Types::Strict::Bool

      primary_key :id

      associations do
        belongs_to :user
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
