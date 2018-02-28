defmodule Tasktrackerapp.TaskInfo.Manage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktrackerapp.TaskInfo.Manage
  alias Tasktrackerapp.Taskinfo.User


  schema "authority" do

    belongs_to :manager, User
    belongs_to :managee, User
    

    timestamps()
  end

  @doc false
  def changeset(%Manage{} = manage, attrs) do
    manage
    |> cast(attrs, [:manager_id, :managee_id])
    |> validate_required([:manager_id, :managee_id])
  end
end
