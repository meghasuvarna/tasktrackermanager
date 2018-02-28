defmodule TasktrackerappWeb.ManageView do
  use TasktrackerappWeb, :view
  alias TasktrackerappWeb.ManageView

  def render("index.json", %{authority: authority}) do
    %{data: render_many(authority, ManageView, "manage.json")}
  end

  def render("show.json", %{manage: manage}) do
    %{data: render_one(manage, ManageView, "manage.json")}
  end

  def render("manage.json", %{manage: manage}) do
    %{id: manage.id}
  end
end
