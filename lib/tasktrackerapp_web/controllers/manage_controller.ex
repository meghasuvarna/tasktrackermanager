defmodule TasktrackerappWeb.ManageController do
  use TasktrackerappWeb, :controller

  alias Tasktrackerapp.TaskInfo
  alias Tasktrackerapp.TaskInfo.Manage

  action_fallback TasktrackerappWeb.FallbackController

  def index(conn, _params) do
    authority = TaskInfo.list_authority()
    render(conn, "index.json", authority: authority)
  end

  def create(conn, %{"manage" => manage_params}) do
   
  end

  def show(conn, %{"id" => id}) do
    
  end

  def update(conn, %{"id" => id, "manage" => manage_params}) do
   
  end

  def delete(conn, %{"id" => id}) do
  
end
end