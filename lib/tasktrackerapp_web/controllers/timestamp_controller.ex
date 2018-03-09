defmodule TasktrackerappWeb.TimestampController do
  use TasktrackerappWeb, :controller

  alias Tasktrackerapp.Block
  alias Tasktrackerapp.Block.Timestamp

  action_fallback TasktrackerappWeb.FallbackController

  def index(conn, _params) do
    blocks = Block.list_blocks()
    render(conn, "index.json", blocks: blocks)
  end

  def create(conn, %{"task_id" => task_id, "start_year" => start_year, "start_month" => start_month, "start_date" => start_date, "start_hour" => start_hour, "start_minute" => start_minute,
  "end_year" => end_year, "end_month" => end_month, "end_date" => end_date, "end_hour" => end_hour, "end_minute" => end_minute} ) do


   startime = %DateTime{year: start_year, month: start_month, day: start_date,
    hour: start_hour, minute: start_minute, second: 00,
    zone_abbr: "AMT", time_zone: "America/Manaus",  utc_offset: -14400,
    std_offset: 0} |> DateTime.to_naive()
    
     task = Tasktrackerapp.TaskInfo.get_task!(task_id)

     endtime = %DateTime{year: end_year, month: end_month, day: end_date,
    hour: end_hour, minute: end_minute, second: 00,
    zone_abbr: "AMT", time_zone: "America/Manaus",  utc_offset: -14400,
    std_offset: 0} |> DateTime.to_naive() 

     with {:ok, %Timestamp{} = timestamp} <- Block.create_timestamp(%{task_id: task_id,
    starttime: startime, endtime: endtime}) do

        conn
        
        |> redirect(to: task_path(conn, :show, task))  
       
     
     

end
   
  end

  def show(conn, %{"id" => id}) do
    timestamp = Block.get_timestamp!(id)
    render(conn, "show.json", timestamp: timestamp)
  end




  def update(conn, %{"id" => id, "timestamp" => %{"task_id" => task_id, "start_year" => start_year, "start_month" => start_month, "start_date" => start_date, "start_hour" => start_hour, "start_minute" => start_minute,
  "end_year" => end_year, "end_month" => end_month, "end_date" => end_date, "end_hour" => end_hour, "end_minute" => end_minute}}) do
    timestamp = Block.get_timestamp!(id)

 startime = %DateTime{year: start_year, month: start_month, day: start_date,
    hour: start_hour, minute: start_minute, second: 00,
    zone_abbr: "AMT", time_zone: "America/Manaus",  utc_offset: -14400,
    std_offset: 0} |> DateTime.to_naive()
    
     task = Tasktrackerapp.TaskInfo.get_task!(task_id)

     endtime = %DateTime{year: end_year, month: end_month, day: end_date,
    hour: end_hour, minute: end_minute, second: 00,
    zone_abbr: "AMT", time_zone: "America/Manaus",  utc_offset: -14400,
    std_offset: 0} |> DateTime.to_naive() 


    timestamp_params = %{task_id: task_id,starttime: startime, endtime: endtime}
    
    with {:ok, %Timestamp{} = timestamp} <- Block.update_timestamp(timestamp, timestamp_params) do
      
      conn
        
        |> redirect(to: task_path(conn, :show, task))  
          
    end
  end



  def delete(conn, %{"id" => id}) do
    timestamp = Block.get_timestamp!(id)
    task = Tasktrackerapp.TaskInfo.get_task!(timestamp.task_id)
    with {:ok, %Timestamp{}} <- Block.delete_timestamp(timestamp) do
    
       conn
        
        |> redirect(to: task_path(conn, :show, task))  
    end
  end
end
