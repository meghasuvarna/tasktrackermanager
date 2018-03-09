// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import $ from "jquery";
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

let currentdate = 0;

function update_buttons() {
  $('.start-button').each( (_, bb) => {
    let task_id = $(bb).data('task-id');
    let flag = $(bb).data('flag');
    if (flag == 0) {
      $(bb).text("Stop task");
    }
    else {
      $(bb).text("Start automated task tracker");
    }
  });
}

function set_button(task_id, value) {
  $('.start-button').each( (_, bb) => {
    if (task_id == $(bb).data('task-id')) {
      $(bb).data('flag', value);
    }
  });
  update_buttons();
}

function starttask(task_id) {
	console.log("started")
	 currentdate = new Date();
   set_button(task_id, 0);
}

function endtask(task_id) {
   console.log("end")
    set_button(task_id, 1);
    let end = new Date();
	 let text = JSON.stringify({
   
        task_id: task_id,
        start_year: currentdate.getFullYear(),
        start_month: currentdate.getMonth() + 1,
        start_date: currentdate.getDate(),
        start_hour: currentdate.getHours(),
        start_minute: currentdate.getMinutes(),
        end_year: end.getFullYear(),
        end_month: end.getMonth() + 1,
        end_date: end.getDate(),
        end_hour: end.getHours(),
        end_minute: end.getMinutes()
        
      
  });
 console.log(text)
  $.ajax(timestamp_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: () => { set_button(task_id, 0);   
},
  });
 location.reload();
}

function start_click(ev) {
	
  let btn = $(ev.target);
  let task_id = btn.data('task-id');
  let flag = btn.data('flag');
  console.log(task_id)
  if (flag == 1) {
    starttask(task_id);
  }
  else {
    endtask(task_id);
  }
}

function init_start() {
  console.log("hi")
  if (!$('.start-button')) {
    return;
  }

  $(".start-button").click(start_click);

  update_buttons();
}

$(init_start);
