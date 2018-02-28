defmodule Tasktrackerapp.Repo.Migrations.CreateAuthority do
  use Ecto.Migration

  def change do
    create table(:authority) do
      add :manager_id, references(:users, on_delete: :delete_all), null: false
      add :managee_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:authority, [:manager_id])
    create index(:authority, [:managee_id])
  end
end
