ROM::SQL.migration do
  change do
    alter_table :todos do
      drop_column :user_id
      add_foreign_key :todo_list_id, :todo_lists
    end
  end
end
