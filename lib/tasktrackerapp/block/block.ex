defmodule Tasktrackerapp.Block do
  @moduledoc """
  The Block context.
  """

  import Ecto.Query, warn: false
  alias Tasktrackerapp.Repo

  
  alias Tasktrackerapp.Block.Timestamp

  @doc """
  Returns the list of blocks.

  ## Examples

      iex> list_blocks()
      [%Timestamp{}, ...]

  """
  def list_blocks do
    Repo.all(Timestamp)
    |> Repo.preload(:task)
  end

  def list_block_by_id(taskid)
  do
  q = from t in Timestamp, where: t.task_id == ^taskid, limit: 1, order_by: [desc: t.id]
  Repo.one(q)
  end

  @doc """
  Gets a single timestamp.

  Raises `Ecto.NoResultsError` if the Timestamp does not exist.

  ## Examples

      iex> get_timestamp!(123)
      %Timestamp{}

      iex> get_timestamp!(456)
      ** (Ecto.NoResultsError)

  """
  def get_timestamp!(id) do
   Repo.get!(Timestamp, id)
   |> Repo.preload(:task)
  end
  @doc """
  Creates a timestamp.

  ## Examples

      iex> create_timestamp(%{field: value})
      {:ok, %Timestamp{}}

      iex> create_timestamp(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_timestamp(attrs \\ %{}) do

    %Timestamp{}
    |> Timestamp.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a timestamp.

  ## Examples

      iex> update_timestamp(timestamp, %{field: new_value})
      {:ok, %Timestamp{}}

      iex> update_timestamp(timestamp, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_timestamp(%Timestamp{} = timestamp, attrs) do
    timestamp
    |> Timestamp.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Timestamp.

  ## Examples

      iex> delete_timestamp(timestamp)
      {:ok, %Timestamp{}}

      iex> delete_timestamp(timestamp)
      {:error, %Ecto.Changeset{}}

  """
  def delete_timestamp(%Timestamp{} = timestamp) do
    Repo.delete(timestamp)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking timestamp changes.

  ## Examples

      iex> change_timestamp(timestamp)
      %Ecto.Changeset{source: %Timestamp{}}

  """
  def change_timestamp(%Timestamp{} = timestamp) do
    Timestamp.changeset(timestamp, %{})
  end
end
