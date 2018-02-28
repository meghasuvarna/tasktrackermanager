defmodule TasktrackerappWeb.TimestampControllerTest do
  use TasktrackerappWeb.ConnCase

  alias Tasktrackerapp.Block
  alias Tasktrackerapp.Block.Timestamp

  @create_attrs %{endtime: ~N[2010-04-17 14:00:00.000000], starttime: ~N[2010-04-17 14:00:00.000000]}
  @update_attrs %{endtime: ~N[2011-05-18 15:01:01.000000], starttime: ~N[2011-05-18 15:01:01.000000]}
  @invalid_attrs %{endtime: nil, starttime: nil}

  def fixture(:timestamp) do
    {:ok, timestamp} = Block.create_timestamp(@create_attrs)
    timestamp
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all blocks", %{conn: conn} do
      conn = get conn, timestamp_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create timestamp" do
    test "renders timestamp when data is valid", %{conn: conn} do
      conn = post conn, timestamp_path(conn, :create), timestamp: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, timestamp_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "endtime" => ~N[2010-04-17 14:00:00.000000],
        "starttime" => ~N[2010-04-17 14:00:00.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, timestamp_path(conn, :create), timestamp: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update timestamp" do
    setup [:create_timestamp]

    test "renders timestamp when data is valid", %{conn: conn, timestamp: %Timestamp{id: id} = timestamp} do
      conn = put conn, timestamp_path(conn, :update, timestamp), timestamp: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, timestamp_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "endtime" => ~N[2011-05-18 15:01:01.000000],
        "starttime" => ~N[2011-05-18 15:01:01.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn, timestamp: timestamp} do
      conn = put conn, timestamp_path(conn, :update, timestamp), timestamp: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete timestamp" do
    setup [:create_timestamp]

    test "deletes chosen timestamp", %{conn: conn, timestamp: timestamp} do
      conn = delete conn, timestamp_path(conn, :delete, timestamp)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, timestamp_path(conn, :show, timestamp)
      end
    end
  end

  defp create_timestamp(_) do
    timestamp = fixture(:timestamp)
    {:ok, timestamp: timestamp}
  end
end
