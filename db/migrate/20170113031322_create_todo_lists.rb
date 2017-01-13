ROM::SQL.migration do
  change do
    create_table(:todo_lists) do
      primary_key :id

      Int :user_id, null: false, foreign_key: true
      String :title, null: false
    end
  end
end
