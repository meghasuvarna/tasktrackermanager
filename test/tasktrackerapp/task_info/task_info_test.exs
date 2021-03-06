defmodule Tasktrackerapp.TaskInfoTest do
  use Tasktrackerapp.DataCase

  alias Tasktrackerapp.TaskInfo

  describe "tasks" do
    alias Tasktrackerapp.TaskInfo.Task

    @valid_attrs %{completed: true, description: "some description", timetaken: 42, title: "some title"}
    @update_attrs %{completed: false, description: "some updated description", timetaken: 43, title: "some updated title"}
    @invalid_attrs %{completed: nil, description: nil, timetaken: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TaskInfo.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert TaskInfo.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert TaskInfo.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = TaskInfo.create_task(@valid_attrs)
      assert task.completed == true
      assert task.description == "some description"
      assert task.timetaken == 42
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskInfo.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = TaskInfo.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.completed == false
      assert task.description == "some updated description"
      assert task.timetaken == 43
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskInfo.update_task(task, @invalid_attrs)
      assert task == TaskInfo.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = TaskInfo.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> TaskInfo.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = TaskInfo.change_task(task)
    end
  end

  describe "authority" do
    alias Tasktrackerapp.TaskInfo.Manage

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def manage_fixture(attrs \\ %{}) do
      {:ok, manage} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TaskInfo.create_manage()

      manage
    end

    test "list_authority/0 returns all authority" do
      manage = manage_fixture()
      assert TaskInfo.list_authority() == [manage]
    end

    test "get_manage!/1 returns the manage with given id" do
      manage = manage_fixture()
      assert TaskInfo.get_manage!(manage.id) == manage
    end

    test "create_manage/1 with valid data creates a manage" do
      assert {:ok, %Manage{} = manage} = TaskInfo.create_manage(@valid_attrs)
    end

    test "create_manage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskInfo.create_manage(@invalid_attrs)
    end

    test "update_manage/2 with valid data updates the manage" do
      manage = manage_fixture()
      assert {:ok, manage} = TaskInfo.update_manage(manage, @update_attrs)
      assert %Manage{} = manage
    end

    test "update_manage/2 with invalid data returns error changeset" do
      manage = manage_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskInfo.update_manage(manage, @invalid_attrs)
      assert manage == TaskInfo.get_manage!(manage.id)
    end

    test "delete_manage/1 deletes the manage" do
      manage = manage_fixture()
      assert {:ok, %Manage{}} = TaskInfo.delete_manage(manage)
      assert_raise Ecto.NoResultsError, fn -> TaskInfo.get_manage!(manage.id) end
    end

    test "change_manage/1 returns a manage changeset" do
      manage = manage_fixture()
      assert %Ecto.Changeset{} = TaskInfo.change_manage(manage)
    end
  end
end
