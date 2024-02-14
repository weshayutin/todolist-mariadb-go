export date=`date "+%F-%T"`
curl -d "description=curl_todo_1_$date&completed=false" -X POST http://localhost:8000/todo
curl -d "description=curl_todo_2_$date&completed=false" -X POST http://localhost:8000/todo
curl -d "description=curl_todo_3_$date&completed=false" -X POST http://localhost:8000/todo
curl -d "id=1&completed=true" -X POST http://localhost:8000/todo/1



