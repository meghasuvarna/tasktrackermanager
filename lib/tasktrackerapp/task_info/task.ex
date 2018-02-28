defmodule Tasktrackerapp.TaskInfo.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktrackerapp.TaskInfo.Task


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :timetaken, :integer
    field :title, :string
    belongs_to :user, Tasktrackerapp.Accounts.User
    has_many :tracker, Tasktrackerapp.Block.Timestamp, foreign_key: :task_id
    has_many :timer , through: [:tracker, :task]

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :timetaken, :user_id])
    |> validate_required([:title, :description, :completed, :timetaken, :user_id])
  end
end
