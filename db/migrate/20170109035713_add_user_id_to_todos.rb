ROM::SQL.migration do
  change do
    alter_table(:todos) { add_foreign_key :user_id, :users }
  end
end
