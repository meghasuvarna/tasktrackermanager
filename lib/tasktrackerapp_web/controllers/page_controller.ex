defmodule TasktrackerappWeb.PageController do
  use TasktrackerappWeb, :controller

  alias Tasktrackerapp.Accounts
  alias Tasktrackerapp.TaskInfo

  def index(conn, _params) do
    render conn, "index.html"
  end


  def taskslist(conn, _params) do
    tasks = TaskInfo.list_tasks()
    users = Accounts.list_users()
    render(conn, "taskslist.html", tasks: tasks, users: users)
  end


  def manage(conn, _params) do
    current_user = conn.assigns[:current_user]
    users = Accounts.list_users()
    tasks = TaskInfo.list_tasks()
    
   
    render(conn, "manage.html", users: users, tasks: tasks)
   end

    def managetasks(conn, _params) do
    current_user = conn.assigns[:current_user]
 
     users = Accounts.list_users()
            |> Enum.filter(fn(m) -> m.manager_id == conn.assigns.current_user.id 
            end)
    tasks = TaskInfo.list_tasks()
    
    manages = Tasktrackerapp.TaskInfo.manages_map_for(current_user.id)
    render(conn, "manageetasks.html", users: users, manages: manages, tasks: tasks)
   end
  end
