defmodule TasktrackerappWeb.TaskController do
  use TasktrackerappWeb, :controller

  alias Tasktrackerapp.TaskInfo
  alias Tasktrackerapp.TaskInfo.Task
  alias Tasktrackerapp.Accounts

  def index(conn, _params) do
  
    tasks = TaskInfo.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    usersoptions = Accounts.list_users()
            |> Enum.filter(fn(m) -> m.manager_id == conn.assigns.current_user.id 
            end)
    users = Accounts.list_users()
    changeset = TaskInfo.change_task(%Task{})
    render(conn, "new.html", changeset: changeset, users: users, usersoptions: usersoptions)
  end

  def create(conn, %{"task" => task_params}) do
  users = Tasktrackerapp.Accounts.list_users()
  usersoptions =  Tasktrackerapp.Accounts.list_users()
                    |> Enum.map(&[&1.id])
                    |> Enum.concat()
  
    case TaskInfo.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset , users: users, usersoptions: usersoptions)
    end
    end

  def show(conn, %{"id" => id}) do
    task = TaskInfo.get_task!(id)
     
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
   usersoptions = Accounts.list_users()
            |> Enum.filter(fn(m) -> m.manager_id == conn.assigns.current_user.id 
            end)
    task = TaskInfo.get_task!(id)
    changeset = TaskInfo.change_task(task)
    users = Tasktrackerapp.Accounts.list_users()
    render(conn, "edit.html", task: task, changeset: changeset, users: users, usersoptions: usersoptions)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
  
            IO.puts("hujij")
    task = TaskInfo.get_task!(id)
      usersoptions = Accounts.list_users()
            |> Enum.filter(fn(m) -> m.manager_id == conn.assigns.current_user.id 
            end)

            IO.puts("hujij")
    case TaskInfo.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset, usersoptions: usersoptions)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = TaskInfo.get_task!(id)
    {:ok, _task} = TaskInfo.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: "/taskslist")
  end
end


#attribution: https://stackoverflow.com/questions/36698192/how-to-create-a-select-tag-with-options-and-values-from-a-separate-model-in-the
#Also followed as per the instructions in Nat notes.