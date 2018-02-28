defmodule TasktrackerappWeb.TimestampView do
  use TasktrackerappWeb, :view
  alias TasktrackerappWeb.TimestampView

  def render("index.json", %{t: t}) do
    %{data: render_many(t, TimestampView, "timestamp.json")}
  end

  def render("show.json", %{timestamp: timestamp}) do
    %{data: render_one(timestamp, TimestampView, "timestamp.json")}
  end

  def render("timestamp.json", %{timestamp: timestamp}) do
    %{id: timestamp.id,
      blocks: timestamp.blocks,
      starttime: timestamp.starttime,
      endtime: timestamp.endtime}
  end
end
