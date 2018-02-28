defmodule Tasktrackerapp.Block.Timestamp do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktrackerapp.Block.Timestamp
  alias Tasktrackerapp.TaskInfo.Task


  schema "blocks" do
    field :endtime, :naive_datetime
    field :starttime, :naive_datetime
    belongs_to :task, Task
    timestamps()
  end

  @doc false
  def changeset(%Timestamp{} = timestamp, attrs) do
    timestamp
    |> cast(attrs, [:starttime, :endtime, :task_id])
    |> validate_required([:task_id])
  end
end
