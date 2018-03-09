defmodule TasktrackerappWeb.PageController do
use TasktrackerappWeb, :controller

alias Tasktrackerapp.Accounts
alias Tasktrackerapp.TaskInfo
 alias Tasktrackerapp.Block
  alias Tasktrackerapp.Block.Timestamp

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

  def addtimeblock(conn, _params ) do
   task = TaskInfo.get_task!(_params["task_id"])
       
  render(conn, "addtimeblock.html", task: task) 
  end

  def edittimeblock(conn, _params) do
    IO.inspect(_params["timeblock_id"])
    task = TaskInfo.get_task!(_params["task_id"])
    timeblock = Block.get_timestamp!(_params["timeblock_id"])
    changeset = Block.change_timestamp(timeblock)
    render(conn, "edittimeblock.html", timeblock: timeblock, changeset: changeset, task: task) 
    
  end


end
