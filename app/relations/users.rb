require "rom"

module Relations
  class Users < ROM::Relation[:sql]
    schema(:users) do
      attribute :id, Types::Serial
      attribute :email, Types::Strict::String
      attribute :first_name, Types::Strict::String
      attribute :last_name, Types::Strict::String

      primary_key :id

      associations do
        has_many :todos
      end
    end

    def by_id(id)
      where(id: id)
    end
  end
end
