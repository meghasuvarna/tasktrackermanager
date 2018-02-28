defmodule Tasktrackerapp.Repo.Migrations.CreateBlocks do
  use Ecto.Migration

  def change do
    create table(:blocks) do
      add :starttime, :naive_datetime
      add :endtime, :naive_datetime
      add :task_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:blocks, [:task_id])
  end
end
