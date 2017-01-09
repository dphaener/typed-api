require "sequel"

Sequel.migration do
  up do
    create_table(:todos) do
      primary_key :id

      String :title, null: false
      String :description, null: false
      String :complete, default: false, null: false
    end
  end
end
