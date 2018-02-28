defmodule Tasktrackerapp.BlockTest do
  use Tasktrackerapp.DataCase

  alias Tasktrackerapp.Block

  describe "t" do
    alias Tasktrackerapp.Block.Timestamp

    @valid_attrs %{blocks: "some blocks", endtime: ~N[2010-04-17 14:00:00.000000], starttime: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{blocks: "some updated blocks", endtime: ~N[2011-05-18 15:01:01.000000], starttime: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{blocks: nil, endtime: nil, starttime: nil}

    def timestamp_fixture(attrs \\ %{}) do
      {:ok, timestamp} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Block.create_timestamp()

      timestamp
    end

    test "list_t/0 returns all t" do
      timestamp = timestamp_fixture()
      assert Block.list_t() == [timestamp]
    end

    test "get_timestamp!/1 returns the timestamp with given id" do
      timestamp = timestamp_fixture()
      assert Block.get_timestamp!(timestamp.id) == timestamp
    end

    test "create_timestamp/1 with valid data creates a timestamp" do
      assert {:ok, %Timestamp{} = timestamp} = Block.create_timestamp(@valid_attrs)
      assert timestamp.blocks == "some blocks"
      assert timestamp.endtime == ~N[2010-04-17 14:00:00.000000]
      assert timestamp.starttime == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_timestamp/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Block.create_timestamp(@invalid_attrs)
    end

    test "update_timestamp/2 with valid data updates the timestamp" do
      timestamp = timestamp_fixture()
      assert {:ok, timestamp} = Block.update_timestamp(timestamp, @update_attrs)
      assert %Timestamp{} = timestamp
      assert timestamp.blocks == "some updated blocks"
      assert timestamp.endtime == ~N[2011-05-18 15:01:01.000000]
      assert timestamp.starttime == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_timestamp/2 with invalid data returns error changeset" do
      timestamp = timestamp_fixture()
      assert {:error, %Ecto.Changeset{}} = Block.update_timestamp(timestamp, @invalid_attrs)
      assert timestamp == Block.get_timestamp!(timestamp.id)
    end

    test "delete_timestamp/1 deletes the timestamp" do
      timestamp = timestamp_fixture()
      assert {:ok, %Timestamp{}} = Block.delete_timestamp(timestamp)
      assert_raise Ecto.NoResultsError, fn -> Block.get_timestamp!(timestamp.id) end
    end

    test "change_timestamp/1 returns a timestamp changeset" do
      timestamp = timestamp_fixture()
      assert %Ecto.Changeset{} = Block.change_timestamp(timestamp)
    end
  end

  describe "blocks" do
    alias Tasktrackerapp.Block.Timestamp

    @valid_attrs %{endtime: ~N[2010-04-17 14:00:00.000000], starttime: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{endtime: ~N[2011-05-18 15:01:01.000000], starttime: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{endtime: nil, starttime: nil}

    def timestamp_fixture(attrs \\ %{}) do
      {:ok, timestamp} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Block.create_timestamp()

      timestamp
    end

    test "list_blocks/0 returns all blocks" do
      timestamp = timestamp_fixture()
      assert Block.list_blocks() == [timestamp]
    end

    test "get_timestamp!/1 returns the timestamp with given id" do
      timestamp = timestamp_fixture()
      assert Block.get_timestamp!(timestamp.id) == timestamp
    end

    test "create_timestamp/1 with valid data creates a timestamp" do
      assert {:ok, %Timestamp{} = timestamp} = Block.create_timestamp(@valid_attrs)
      assert timestamp.endtime == ~N[2010-04-17 14:00:00.000000]
      assert timestamp.starttime == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_timestamp/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Block.create_timestamp(@invalid_attrs)
    end

    test "update_timestamp/2 with valid data updates the timestamp" do
      timestamp = timestamp_fixture()
      assert {:ok, timestamp} = Block.update_timestamp(timestamp, @update_attrs)
      assert %Timestamp{} = timestamp
      assert timestamp.endtime == ~N[2011-05-18 15:01:01.000000]
      assert timestamp.starttime == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_timestamp/2 with invalid data returns error changeset" do
      timestamp = timestamp_fixture()
      assert {:error, %Ecto.Changeset{}} = Block.update_timestamp(timestamp, @invalid_attrs)
      assert timestamp == Block.get_timestamp!(timestamp.id)
    end

    test "delete_timestamp/1 deletes the timestamp" do
      timestamp = timestamp_fixture()
      assert {:ok, %Timestamp{}} = Block.delete_timestamp(timestamp)
      assert_raise Ecto.NoResultsError, fn -> Block.get_timestamp!(timestamp.id) end
    end

    test "change_timestamp/1 returns a timestamp changeset" do
      timestamp = timestamp_fixture()
      assert %Ecto.Changeset{} = Block.change_timestamp(timestamp)
    end
  end
end
